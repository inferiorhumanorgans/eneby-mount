#!/usr/bin/env python3

import pymeshlab

ms = pymeshlab.MeshSet()

ms.load_new_mesh("assets/97151A106_Steel Screws for Joining Drywall to Wood.stl")
ms.set_current_mesh(0)
ms.compute_matrix_from_scaling_or_normalization(axisx=25.4, axisy=25.4, axisz=25.4)
ms.compute_matrix_from_rotation(rotaxis=1, angle=90)
ms.compute_matrix_from_translation(traslmethod=0, axisx=0, axisy=42.5, axisz=-28)
ms.compute_color_by_function_per_vertex(x="173", y="210", z="128", a="255")
ms.save_current_mesh("build/97151A106_Steel Screws for Joining Drywall to Wood.ply")

ms.load_new_mesh("assets/91290A432_Black-Oxide Alloy Steel Socket Head Screw.stl")
ms.set_current_mesh(1)
ms.compute_matrix_from_scaling_or_normalization(axisx=25.4, axisy=25.4, axisz=25.4)
ms.compute_matrix_from_rotation(rotaxis=1, angle=180)
ms.compute_matrix_from_translation(traslmethod=0, axisx=0, axisy=0, axisz=20)
ms.compute_color_by_function_per_vertex(x="173", y="210", z="128", a="255")
ms.save_current_mesh("build/91290A432_Black-Oxide Alloy Steel Socket Head Screw.ply")

ms = pymeshlab.MeshSet()
ms.load_new_mesh("build/standoff.stl")

ms.load_new_mesh("build/97151A106_Steel Screws for Joining Drywall to Wood.ply")
ms.load_new_mesh("build/91290A432_Black-Oxide Alloy Steel Socket Head Screw.ply")
ms.save_project("standoff.mlp")
