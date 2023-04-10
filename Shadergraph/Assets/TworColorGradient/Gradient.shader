Shader "Custom/Gradient"
{
    Properties {
        _Color1 ("Bottom Color", Color) = (0, 0, 0, 1)
        _Color2 ("Top Color", Color) = (1, 1, 1, 1)
        _BlendPoint ("Blend Point", Range(0,1)) = 0.5
    }

    SubShader {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
            };

            struct v2f {
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
            };

            float4 _Color1;
            float4 _Color2;
            float _BlendPoint;

            v2f vert (appdata v) {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                // Calculate the gradient color based on the vertex position and blend point
                float t = saturate((o.vertex.y - _BlendPoint) / (1 - _BlendPoint));
                o.color = lerp(_Color1, _Color2, t);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target {
                return i.color;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}