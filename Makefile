build/standoff.mlp: build/standoff.stl assets/91290A432_Black-Oxide\ Alloy\ Steel\ Socket\ Head\ Screw.stl assets/97151A106_Steel\ Screws\ for\ Joining\ Drywall\ to\ Wood.stl
	@./build-meshlab-project.py

build/standoff.stl: assets/standoff.scad build
	@extopenscad --fopenscad-compat assets/standoff.scad -o build/standoff.stl

build:
	@mkdir build

clean:
	@rm -r build
