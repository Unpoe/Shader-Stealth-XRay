using UnityEngine;

public class RayVisionEffect : MonoBehaviour
{
    [Range(0, 1)] public float Progress = 0.0f;
    [Space]
    [SerializeField] private Shader replacementShader = default;
    [SerializeField] private Camera replacementCamera = default;
    [Space]
    public float progressSpeedChange = 1.0f;
    public AnimationCurve progressCurve = default;

    private void OnEnable() {
        replacementCamera.SetReplacementShader(replacementShader, "XRay");
    }

    private void Update() {
        float targetProgress = Input.GetKey(KeyCode.LeftShift) ? 1 : 0;
        if (Progress != targetProgress) {
            Progress = Mathf.MoveTowards(Progress, targetProgress, progressSpeedChange * Time.deltaTime);
        }

        float easedProgress = progressCurve.Evaluate(Progress);
        Shader.SetGlobalFloat("_GlobalXRayVisibility", easedProgress);
    }
}
