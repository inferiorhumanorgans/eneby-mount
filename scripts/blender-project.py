import bpy
import math
import os
from datetime import datetime

try:
    # proj_name = datetime.now().strftime("standoff-%F%T.blend")
    # proj_path = os.getcwd() + "/build/" + proj_name
    proj_path = os.getcwd() + "/build/standoff.blend"

    # https://blender.stackexchange.com/questions/27234/python-how-to-completely-remove-an-object
    bpy.ops.object.select_all(action='DESELECT')
    bpy.data.objects['Cube'].select_set(True)
    bpy.ops.object.delete()

    # Project needs to be saved before the // path expansion will work
    bpy.ops.wm.save_as_mainfile(filepath=proj_path)

    bpy.ops.import_mesh.stl(filepath=bpy.path.abspath("//../build/standoff.stl"))
    standoff=bpy.context.scene.objects["standoff"]
    standoff.scale = (1/25.4, 1/25.4, 1/25.4)
    #bpy.context.view_layer.objects.active = standoff
    mat = bpy.data.materials.new(name="standoff_skin")
    mat.diffuse_color = (1, 0.136, 0, 1)
    standoff.data.materials.append(mat)

    bpy.ops.import_mesh.stl(filepath=bpy.path.abspath("//../assets/91290A432_Black-Oxide Alloy Steel Socket Head Screw.stl"))
    speaker_screw=bpy.context.scene.objects["91290A432_Black-Oxide Alloy Steel Socket Head Screw"]
    speaker_screw.location = (0, 0, 1)
    speaker_screw.rotation_euler = (0, math.radians(180), 0)
    mat = bpy.data.materials.new(name="speaker_screw_skin")
    mat.diffuse_color = (0.011, 0.047, 0.220, 1)
    speaker_screw.data.materials.append(mat)

    bpy.ops.wm.save_as_mainfile(filepath=proj_path)

    bpy.ops.wm.quit_blender()

except Exception as e:
    print("error", e)
    # print_exception()
    bpy.ops.wm.quit_blender()

print("done")
