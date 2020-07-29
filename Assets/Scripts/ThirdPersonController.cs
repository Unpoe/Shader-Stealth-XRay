using UnityEngine;

public class ThirdPersonController : MonoBehaviour
{
    [SerializeField] private CharacterController characterController = default;
    [SerializeField] private Camera mainCamera = default;
    [SerializeField] private Animator animator = default;
    [SerializeField] private LayerMask cameraCollisionMask = default;
    [Space]
    public float MaxSpeed = 1.0f;
    public float CameraDistance = 2.0f;
    public Vector3 CameraOffset = new Vector3(0, 1.2f, 0);
    public float MouseSensibility = 10.0f;

    private Vector3 velocity = Vector3.zero;

    private float cameraRotationX = 0;
    private float cameraRotationY = 0;

    private static int NORMALIZEDVELOCITY_ANIMPARAM = Animator.StringToHash("normalizedVelocity");

    private void Start() {
        Cursor.lockState = CursorLockMode.Locked;
        Cursor.visible = false;
    }

    private void Update() {
        float mouseX = Input.GetAxis("Mouse X");
        float mouseY = Input.GetAxis("Mouse Y");
        float horizontalInput = Input.GetAxis("Horizontal");
        float verticalInput = Input.GetAxis("Vertical");

        cameraRotationX += mouseY * MouseSensibility * Time.deltaTime;
        cameraRotationY += mouseX * MouseSensibility * Time.deltaTime;

        cameraRotationX = Mathf.Clamp(cameraRotationX, -90, 90);

        Quaternion localRotation = Quaternion.Euler(cameraRotationX, cameraRotationY, 0.0f);
        Transform camTransform = mainCamera.transform;
        camTransform.rotation = localRotation;
        Transform cachedTransform = transform;
        camTransform.position = cachedTransform.position + CameraOffset - camTransform.forward * ComputeCameraDistance(cachedTransform, camTransform);

        velocity = camTransform.right * horizontalInput + camTransform.forward * verticalInput;
        velocity *= MaxSpeed;
        velocity.y = -10;

        if (horizontalInput != 0 || verticalInput != 0) {
            Vector3 characterForward = velocity;
            characterForward.y = 0;
            characterForward.Normalize();
            cachedTransform.forward = characterForward;
        }

        characterController.Move(velocity * Time.deltaTime);

        Vector3 cachedVelocity = velocity;
        cachedVelocity.y = 0;
        float normaliedVelocity = Utils.Normalize(cachedVelocity.magnitude, 0, MaxSpeed);
        animator.SetFloat(NORMALIZEDVELOCITY_ANIMPARAM, normaliedVelocity);
    }

    private float ComputeCameraDistance(Transform cachedTransform, Transform camTransform) {
        Ray ray = new Ray(cachedTransform.position + CameraOffset, -camTransform.forward);
        RaycastHit hitInfo;
        if (Physics.Raycast(ray, out hitInfo, CameraDistance, cameraCollisionMask)) {
            return hitInfo.distance - 0.05f;
        }

        return CameraDistance;
    }
}
