MAKEFILE=Makefile
VERSION=0.0.0.9000

.PHONY: help

#------------------------------------------------------------------
# Targets
#------------------------------------------------------------------


help:
	@echo ""
	@echo "- Available targets:"
	@echo ""
	@perl -ne 'if(	/^(\w+):/){print "\t",$$1,"\n"}' $(MAKEFILE)
	@echo ""
	@echo ""

clean:
	@rm -f src/*.o src/*.so; rm -f rtrainer.Rcheck/dbfmcl/libs/dbfmcl.so; rm -rf ./dbfmcl.Rcheck; rm -rf ..Rcheck, rm -rf ./..Rcheck/
	@rm -rf /tmp/dbfmcl; rm -rf *dbf_out.txt; rm -rf *mcl_out.txt  rm -rf ./rtrainer.Rcheck
	@rm -f tests/testthat/Rplot*; rm -rf tests/testthat/_snaps
	@rm -f *~

check: clean
	@rm -rf /tmp/rtrainer; mkdir -p /tmp/rtrainer; cp -r ./* /tmp/rtrainer; cd /tmp/rtrainer; \
	rm -f src/*.o src/*.so; rm -f rtrainer.Rcheck/dbfmcl/libs/dbfmcl.so; \
	cd ..; R CMD build rtrainer; R CMD check rtrainer_$(VERSION).tar.gz

run_example:
	@echo "devtools::run_examples(pkg = '.')" | R --slave

checkfast: clean
	@rm -rf /tmp/rtrainer; mkdir -p /tmp/rtrainer; cp -r ./* /tmp/rtrainer; cd /tmp/rtrainer; \
	rm -f src/*.o src/*.so; rm -f rtrainer.Rcheck/dbfmcl/libs/dbfmcl.so; \
	R CMD check --no-install .

doc:
	@echo ">>> Creating a package documentation"
	@echo "library(roxygen2); roxygen2::roxygenise()" | R --slave

install:
	@echo ">>> Installing..."
	@rm -f src/*.o src/*.so
	@R CMD INSTALL .




all: doc install check test
