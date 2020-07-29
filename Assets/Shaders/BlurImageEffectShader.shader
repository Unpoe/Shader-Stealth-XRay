Shader "Custom/Blur Image Effect" {
	Properties {
		_MainTex("Texture", 2D) = "white" {}
		_DisplaceTex("Displacement Texture", 2D) = "white" {}
		_Magnitude("Magnitude", Range(0, 0.01)) = 0
	}
	
	SubShader {
		Cull Off ZWrite Off ZTest Always

		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f {
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			sampler2D _DisplaceTex;
			float _Magnitude;
			uniform float _GlobalXRayVisibility;

			v2f vert(appdata v) {
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			float4 frag(v2f i) : SV_Target{
				//Distortion
				float2 disp = tex2D(_DisplaceTex, i.uv).xy;
				disp = ((disp * 2) - 1) * _Magnitude * _GlobalXRayVisibility;
				disp = disp * sin(_Time.y);

				//Vignette
				float distFromCenter = distance(i.uv.xy, float2(0.5, 0.5));
				float4 vignette = 1 - (float4(distFromCenter, distFromCenter, distFromCenter, 1.0) * _GlobalXRayVisibility);

				float4 col = tex2D(_MainTex, i.uv + disp);
				return col * vignette;
			}
			ENDCG
		}
	}
}