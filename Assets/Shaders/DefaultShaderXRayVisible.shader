Shader "Custom/Default Shader XRay Visible" {
	Properties{
		_Tint("Tint", Color) = (1, 1, 1, 1)
		_MainTex("Texture", 2D) = "white" {}
	}

	SubShader{
		Tags {
			"RenderType" = "Opaque"
			"Queue" = "Geometry-1"
			"PerformanceChecks" = "False"
			"XRay" = "ColoredOuttline"
		}

		Pass {
			CGPROGRAM

			#pragma vertex VertexFunc
			#pragma fragment FragmentFunc

			#include "DefaultUnlit.cginc"

			ENDCG
		}
	}
}