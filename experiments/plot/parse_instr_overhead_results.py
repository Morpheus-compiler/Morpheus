import matplotlib
matplotlib.use('Agg')

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

import argparse
import os
import sys
import shutil
from pathlib import Path


def parse_throughput_data(service):
    results_folder = f'{sys.path[0]}/../{service}/results/throughput'

    if not os.path.exists(results_folder):
        print(f"Results folder {results_folder} does not exist")
        return None

    data = dict()
    for loc in ["low_loc"]:
        data[loc] = dict()
        for test in ["baseline"]:
            file_prefix = f"results_{test}_{loc}_run"
            throughput = []
            for file in os.listdir(results_folder):
                if file.startswith(file_prefix):
                    file_path = os.path.join(results_folder, file)
                    df = pd.read_csv(file_path)
                    # Discard 10 elements at beginning and at end
                    mpps = round(np.mean(df["RX-packets"][15:-15])/1e6, 2)
                    throughput.append(mpps)
            data[loc][test] = np.mean(throughput)

    return data

def parse_instr_overhead_data(service):
    results_folder = f'{sys.path[0]}/../{service}/results/instrumentation_overhead'

    if not os.path.exists(results_folder):
        print(f"Results folder {results_folder} does not exist")
        return None

    data = dict()
    for loc in ["low_loc"]:
        data[loc] = dict()
        for test in ["instr_opt", "instr_overhead"]:
            data[loc][test] = dict()
            for rate in ["1", "5", "25", "50", "75", "100"]:
                file_prefix = f"results_{test}_{rate}_{loc}_run"
                throughput = []
                for file in os.listdir(results_folder):
                    if file.startswith(file_prefix):
                        file_path = os.path.join(results_folder, file)
                        df = pd.read_csv(file_path)
                        # Discard 10 elements at beginning and at end
                        mpps = round(np.mean(df["RX-packets"][15:-15])/1e6, 2)
                        throughput.append(mpps)
                data[loc][test][rate] = np.mean(throughput)

    return data

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Parse adaptive vs naive results for all the services with different traffic localities')
    args = parser.parse_args()

    data_throughput = dict()
    for service in ["router", "bpf-iptables"]:
        service_data = parse_throughput_data(service)
        if not service_data:
            print(f"Error while parsing throughput data for service: {service}")
            sys.exit(1)
        data_throughput[service] = service_data

    data_adaptive_naive = dict()
    for service in ["router", "bpf-iptables"]:
        service_data = parse_instr_overhead_data(service)
        if not service_data:
            print(f"Error while parsing adaptive vs naive data for service: {service}")
            sys.exit(1)
        data_adaptive_naive[service] = service_data

    # Let's now create the final file
    if os.path.exists(f'{sys.path[0]}/data/eval-instrumentation-overhead'):
        shutil.rmtree(f'{sys.path[0]}/data/eval-instrumentation-overhead')
    Path(f'{sys.path[0]}/data/eval-instrumentation-overhead').mkdir(parents=True, exist_ok=True)

    for service in ["router", "bpf-iptables"]:
        with open(f'{sys.path[0]}/data/eval-instrumentation-overhead/{service}.dat','w') as f:
            f.write("#dataplane,baseline,instrumented,optimized (throughput Mpps)\n")
            for rate in ["1", "5", "25", "50", "75", "100"]:
                f.write(f'{rate},{data_throughput[service]["low_loc"]["baseline"]},'
                        f'{data_adaptive_naive[service]["low_loc"]["instr_overhead"][rate]},'
                        f'{data_adaptive_naive[service]["low_loc"]["instr_opt"][rate]}\n')

    print("Results parsed correctly!")
    print(f"The output is in: {sys.path[0]}/data/throughput_eval")