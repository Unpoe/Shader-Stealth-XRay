using UnityEngine;

public class NPC : MonoBehaviour
{
    [SerializeField] private Animator animator = default;

    private static int INITIAL_ANIMSTATE = Animator.StringToHash("lookAround");

    private void Start() {
        animator.Play(INITIAL_ANIMSTATE, 0, Random.value);
    }
}
