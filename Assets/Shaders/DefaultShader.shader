Shader "Custom/Default Shader" {
	Properties{
		_Tint("Tint", Color) = (1, 1, 1, 1)
		_MainTex("Texture", 2D) = "white" {}
	}

	SubShader{
		Tags {
			"RenderType" = "Opaque"
			"PerformanceChecks" = "False"
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