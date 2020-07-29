using UnityEngine;

public class CameraEffect : MonoBehaviour
{
    [SerializeField] private Material effectMaterial = default;

    private void OnRenderImage(RenderTexture source, RenderTexture destination) {
        Graphics.Blit(source, destination, effectMaterial);
    }
}
