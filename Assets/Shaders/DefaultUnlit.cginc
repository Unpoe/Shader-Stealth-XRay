#if !defined(MY_LIGHTING_INCLUDED)
#define DEFAULT_UNLIT_INCLUDED

#include "UnityCG.cginc"

float4 _Tint;
sampler2D _MainTex;
float4 _MainTex_ST;

struct Interpolators {
	float4 position : SV_POSITION;
	float2 uv : TEXCOORD0;
};

struct VertexData {
	float4 position : POSITION;
	float2 uv : TEXCOORD0;
};

Interpolators VertexFunc(VertexData v) {
	Interpolators i;
	i.position = UnityObjectToClipPos(v.position);
	i.uv = TRANSFORM_TEX(v.uv, _MainTex);
	return i;
}

float4 FragmentFunc(Interpolators i) : SV_TARGET{
	return tex2D(_MainTex, i.uv) * _Tint;
}
#endif