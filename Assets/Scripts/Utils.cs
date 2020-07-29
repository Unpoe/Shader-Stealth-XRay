using UnityEngine;

public static class Utils
{
    public static float Normalize(float value, float min, float max) {
        return (value - min) / (max - min);
    }

    public static float Remap(float value, float fromMin, float fromMax, float toMin, float toMax) {
        return (toMax - toMin) * Normalize(value, fromMin, fromMax) + toMin;
    }

    public static Vector3 DirectionFromAngle(float angleInDegrees) {
        return new Vector3(Mathf.Sin(angleInDegrees * Mathf.Deg2Rad), 0, Mathf.Cos(angleInDegrees * Mathf.Deg2Rad));
    }

    public static void ChangeGOToLayer(GameObject gameObject, string layerName, bool changeAllChilds = false) {
        int layer = LayerMask.NameToLayer(layerName);

        gameObject.layer = layer;
        if (changeAllChilds) {
            for (int i = 0; i < gameObject.transform.childCount; i++) {
                GameObject child = gameObject.transform.GetChild(i).gameObject;
                ChangeGOToLayer(child, layerName, true);
            }
        }
    }
}