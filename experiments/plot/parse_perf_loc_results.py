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
    results_folder = f'{sys.path[0]}/../{service}/results/perf'

    if not os.path.exists(results_folder):
        print(f"Results folder {results_folder} does not exist")
        return None

    data = dict()
    for loc in ["high_loc", "low_loc", "no_loc"]:
        data[loc] = dict()
        for test in ["baseline", "morpheus"]:
            file_prefix = f"results_{test}_{loc}_throughput_run"
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

    
def parse_perf_data(service):
    results_folder = f'{sys.path[0]}/../{service}/results/perf'

    if not os.path.exists(results_folder):
        print(f"Results folder {results_folder} does not exist")
        return None

    data = dict()
    for loc in ["high_loc", "low_loc", "no_loc"]:
        data[loc] = dict()
        for test in ["baseline", "morpheus"]:
            file_prefix = f"results_{test}_{loc}_perf_run"
            data[loc][test] = dict()
            cycles = []
            instructions = []
            cache_misses = []
            branches = []
            llc_load_misses = []
            for file in os.listdir(results_folder):
                if file.startswith(file_prefix):
                    file_path = os.path.join(results_folder, file)
                    with open(file_path, "r") as f:
                        lines = f.readlines()
                        for line in lines:
                            res = line.split(",")

                            if "cycles" in res:
                                cycles.append(int(res[0]))
                            elif "instructions" in res:
                                instructions.append(int(res[0]))
                            elif "cache-misses" in res:
                                cache_misses.append(int(res[0]))
                            elif "branches" in res:
                                branches.append(int(res[0]))
                            elif "LLC-load-misses" in res:
                                llc_load_misses.append(int(res[0]))
                            else:
                                continue
            data[loc][test]["cycles"] = round(np.mean(cycles))
            data[loc][test]["instructions"] = round(np.mean(instructions))
            data[loc][test]["cache-misses"] = round(np.mean(cache_misses))
            data[loc][test]["branches"] = round(np.mean(branches))
            data[loc][test]["LLC-load-misses"] = round(np.mean(llc_load_misses))

    return data
                        


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Parse throughput results for all the services with different traffic localities')
    args = parser.parse_args()

    data_throughput = dict()
    data_perf = dict()
    for service in ["router", "switch", "bpf-iptables", "katran"]:
        service_data = parse_throughput_data(service)
        if not service_data:
            print(f"Error while parsing throughput data for service: {service}")
            sys.exit(1)
        data_throughput[service] = service_data

        service_data_perf = parse_perf_data(service)
        if not service_data_perf:
            print(f"Error while parsing perf data for service: {service}")
            sys.exit(1)
        data_perf[service] = service_data_perf

    # Let's now create the final file
    if os.path.exists(f'{sys.path[0]}/data/eval-perf'):
        shutil.rmtree(f'{sys.path[0]}/data/eval-perf')
    Path(f'{sys.path[0]}/data/eval-perf').mkdir(parents=True, exist_ok=True)

    for loc in ["high_loc", "low_loc", "no_loc"]:
        with open(f'{sys.path[0]}/data/eval-perf/{loc}.dat','w') as f:
            f.write("#dataplane,cycles,instructions,cache misses,branches,llc-load-misses\n")
            for service in ["switch", "router", "katran", "bpf-iptables"]:
                # First we calculate the metric based on the throughput we obtained
                baseline_cycles_pp = data_perf[service][loc]["baseline"]["cycles"]/data_throughput[service][loc]["baseline"]
                baseline_instructions_pp = data_perf[service][loc]["baseline"]["instructions"]/data_throughput[service][loc]["baseline"]
                baseline_cache_misses_pp = data_perf[service][loc]["baseline"]["cache-misses"]/data_throughput[service][loc]["baseline"]
                baseline_branches_pp = data_perf[service][loc]["baseline"]["branches"]/data_throughput[service][loc]["baseline"]
                baseline_llc_load_misses_pp = data_perf[service][loc]["baseline"]["LLC-load-misses"]/data_throughput[service][loc]["baseline"]

                # Same for Morpheus
                morpheus_cycles_pp = data_perf[service][loc]["morpheus"]["cycles"]/data_throughput[service][loc]["morpheus"]
                morpheus_instructions_pp = data_perf[service][loc]["morpheus"]["instructions"]/data_throughput[service][loc]["morpheus"]
                morpheus_cache_misses_pp = data_perf[service][loc]["morpheus"]["cache-misses"]/data_throughput[service][loc]["morpheus"]
                morpheus_branches_pp = data_perf[service][loc]["morpheus"]["branches"]/data_throughput[service][loc]["morpheus"]
                morpheus_llc_load_misses_pp = data_perf[service][loc]["morpheus"]["LLC-load-misses"]/data_throughput[service][loc]["morpheus"]
                
                # Let's calculate the reduction
                cycles_reduction = int(((baseline_cycles_pp - morpheus_cycles_pp)/baseline_cycles_pp) *100)
                instructions_reduction = int(((baseline_instructions_pp - morpheus_instructions_pp)/baseline_instructions_pp) *100)
                cache_misses_reduction = int(((baseline_cache_misses_pp - morpheus_cache_misses_pp)/baseline_cache_misses_pp) *100)
                branches_reduction = int(((baseline_branches_pp - morpheus_branches_pp)/baseline_branches_pp) *100)
                llc_load_misses_reduction = int(((baseline_llc_load_misses_pp - morpheus_llc_load_misses_pp)/baseline_llc_load_misses_pp) *100)

                f.write(f'{service},{cycles_reduction},{instructions_reduction},{cache_misses_reduction},{branches_reduction},{llc_load_misses_reduction}\n')

    print("Results parsed correctly!")
    print(f"The output is in: {sys.path[0]}/data/perf_eval")