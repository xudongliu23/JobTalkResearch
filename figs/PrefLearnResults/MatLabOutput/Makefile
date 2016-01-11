all: plot

plot:
#	matlab -nosplash -nodesktop -r "master_function;exit"
	for comm in $(shell ls genfig* | sed 's/.m//g') ; do \
		matlab -nosplash -nodesktop -r "$$comm;exit"; \
	done
