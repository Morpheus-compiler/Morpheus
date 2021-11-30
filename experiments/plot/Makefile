GNUPLOT ?= gnuplot
EPSTOPDF ?= epstopdf
PDF2SVG ?= pdf2svg
PDFTOPPM ?= pdftoppm

all: throughput-loc.eps perf-loc.eps eval-latency.eps \
	 eval-adaptive-vs-naive-instr.eps eval-instrumentation-overhead.eps \
	 eval-dynamic-traffic.eps
	 echo "done"

throughput_loc: throughput-loc.eps
				echo "done"

perf_loc: perf-loc.eps
		  echo "done"

latency: eval-latency.eps
		 echo "done"

adaptive_vs_naive: eval-adaptive-vs-naive-instr.eps
				   echo "done"

instr_overhead: eval-instrumentation-overhead.eps
				echo "done"

dynamic_traffic: eval-dynamic-traffic.eps
				 echo "done"
		 
%.eps: 
	  $(GNUPLOT) scripts/$*.gpl
	  ./fixbb.sh figures/$*.eps
	  $(EPSTOPDF) figures/$*.eps
	  $(PDFTOPPM) figures/$*.pdf figures/$* -png -singlefile
	  $(RM) figures/$*.eps

.PHONY: clean all
clean:
	$(RM) figures/*.pdf figures/*.eps figures/*.png