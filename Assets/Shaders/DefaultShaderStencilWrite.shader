Shader "Custom/Default Shader Stencil Write" {
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
			Stencil {
				Ref 1
				Comp Always
				Pass Replace
			}

			CGPROGRAM

			#pragma vertex VertexFunc
			#pragma fragment FragmentFunc

			#include "DefaultUnlit.cginc"

			ENDCG
		}
	}
}