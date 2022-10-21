.PHONY: blender clean meshlab

blender: build/standoff.blend
	@true

meshlab: build/standoff.mlp
	@true

build/standoff.blend: scripts/blender-project.py build/standoff.stl assets/91290A432_Black-Oxide\ Alloy\ Steel\ Socket\ Head\ Screw.stl assets/97151A106_Steel\ Screws\ for\ Joining\ Drywall\ to\ Wood.stl
	@mkdir build || true
	@/Applications/Blender.app/Contents/MacOS/Blender --python scripts/blender-project.py

build/standoff.mlp: scripts/build-meshlab-project.py build/standoff.stl assets/91290A432_Black-Oxide\ Alloy\ Steel\ Socket\ Head\ Screw.stl assets/97151A106_Steel\ Screws\ for\ Joining\ Drywall\ to\ Wood.stl
	@mkdir build || true
	@./scripts/build-meshlab-project.py
	@mv standoff.mlp build/

build/standoff.stl: assets/standoff.scad
	@mkdir build || true
	@extopenscad --fopenscad-compat assets/standoff.scad -o build/standoff.stl

clean:
	@rm -r build
