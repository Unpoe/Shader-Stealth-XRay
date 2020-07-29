Shader "Custom/XRay Replacement Shader" {
	Properties{
		_Tint("Tint", Color) = (1, 1, 1, 1)
		_MainTex("Texture", 2D) = "white" {}
	}

	SubShader{
		Tags { 
			"Queue" = "Transparent"
			"RenderType" = "Transparent"
			"XRay" = "ColoredOuttline"
		}

		Pass {
			ZWrite On
			ZTest Always
			Blend One One

			Stencil {
				Ref 0
				Comp NotEqual
				Pass keep
			}

			CGPROGRAM

			#pragma vertex VertexFunc
			#pragma fragment FragmentFunc

			#include "UnityCG.cginc"

			float4 _Tint;
			uniform float _GlobalXRayVisibility;

			struct VertexData {
				float4 position : POSITION;
				float3 normal : NORMAL;
				float3 viewDir : TEXCOORD0;
			};

			struct Interpolators {
				float4 position : SV_POSITION;
				float3 normal : NORMAL;
				float3 viewDir : TEXCOORD0;
			};

			Interpolators VertexFunc(VertexData v) {
				Interpolators i;
				i.position = UnityObjectToClipPos(v.position);
				i.normal = UnityObjectToWorldNormal(v.normal);
				i.viewDir = normalize(_WorldSpaceCameraPos.xyz - mul(unity_ObjectToWorld, v.position).xyz);
				return i;
			}

			float4 FragmentFunc(Interpolators i) : SV_TARGET{
				i.normal = normalize(i.normal);
				float ndotv = (1 - dot(i.normal, i.viewDir)) * 1.8;
				return ndotv * _GlobalXRayVisibility * _Tint;
			}

			ENDCG
		}
	}
}