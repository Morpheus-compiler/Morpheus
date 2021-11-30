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
    for loc in ["high_loc", "low_loc", "no_loc"]:
        data[loc] = dict()
        for test in ["baseline", "morpheus"]:
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
                        


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Parse throughput results for all the services with different traffic localities')
    args = parser.parse_args()

    data = dict()
    for service in ["router", "switch", "bpf-iptables", "katran"]:
        service_data = parse_throughput_data(service)
        if not service_data:
            print(f"Error while parsing throughput data for service: {service}")
            sys.exit(1)
        data[service] = service_data

    # Let's now create the final file
    if os.path.exists(f'{sys.path[0]}/data/eval-throughput'):
        shutil.rmtree(f'{sys.path[0]}/data/eval-throughput')
    Path(f'{sys.path[0]}/data/eval-throughput').mkdir(parents=True, exist_ok=True)

    for loc in ["high_loc", "low_loc", "no_loc"]:
        with open(f'{sys.path[0]}/data/eval-throughput/{loc}.dat','w') as f:
            f.write("#dataplane,baseline,morpheus (throughput Mpps)\n")
            for service in ["switch", "router", "katran", "bpf-iptables"]:
                f.write(f'{service},{data[service][loc]["baseline"]},{data[service][loc]["morpheus"]}\n')

    print("Results parsed correctly!")
    print(f"The output is in: {sys.path[0]}/data/throughput_eval")