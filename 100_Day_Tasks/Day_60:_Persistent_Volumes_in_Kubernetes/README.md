### "storageClassName:"

 - Under the spec section of pv.yaml and pvc.yaml what is "storageClassName: manual"

 pv.yaml
 
  ```
spec:
  capacity:
    storage: 4Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: /mnt/security
```


# pvc.yaml

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-datacenter
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: manual
```

 In Kubernetes, ```a StorageClass``` is a way to define the type of storage that a Persistent Volume (PV) provides. It's like a label that describes the characteristics of the storage, such as its performance, availability, and durability.

In the pv.yaml and pvc.yaml files you provided, storageClassName: manual is used to specify that the PV and PVC are manually provisioned.

*What does manual mean?*

When storageClassName is set to manual, it means that the PV is not dynamically provisioned by a storage class. Instead, the PV is manually created and managed by an administrator.

In this case, the manual storage class is not a real storage class that provides any specific storage characteristics. It's more like a placeholder to indicate that the PV is manually provisioned.

*Why use manual?*

Using manual as the storage class name allows you to create a PV and PVC that are not tied to a specific storage class. This can be useful in scenarios where you want to use existing storage infrastructure or manually manage your storage resources.

How does it work?

When you create a PVC with storageClassName: manual, Kubernetes will look for a PV with the same storageClassName that has enough capacity to satisfy the PVC's request. If a matching PV is found, the PVC will be bound to that PV.

In your case, the PV (pv-datacenter) has a capacity of 4Gi, and the PVC (pvc-datacenter) requests 1Gi of storage. Since the PV has enough capacity, the PVC will be bound to the PV, and the pod can use the storage provided by the PV.

Dynamic provisioning

If you were using a dynamic storage provisioner, you wouldn't need to manually create a PV. Instead, you would create a PVC with a specific storage class name, and the provisioner would automatically create a PV with the requested storage characteristics.

For example, if you had a storage class named fast-storage, you could create a PVC like this:
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-fast
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: fast-storage
```
The fast-storage storage class would then dynamically provision a PV with the requested storage characteristics.

### If you've created a PVC with storageClassName: manual and there is no PV with the same storageClassName, the PVC will remain in a Pending state.

Here's what happens:

1. PVC creation: You create a PVC with storageClassName: manual.
2. No matching PV: Kubernetes looks for a PV with the same storageClassName: manual that has enough capacity to satisfy the PVC's request. Since no such PV exists, the PVC cannot be bound to a PV.
3. Pending state: The PVC remains in a Pending state, indicating that it cannot be bound to a PV.

The PVC will stay in this state until:

- A matching PV is created: If you create a PV with the same storageClassName: manual and enough capacity, the PVC will be bound to the PV, and the pod can use the storage.
- The PVC is deleted: If you delete the PVC, it will be removed from the cluster.

In the meantime, you can check the PVC's status using:

bash
kubectl describe pvc <pvc-name>

This will show you the PVC's status and any events related to its creation and binding.

If you want to resolve the issue, you can create a PV with the same storageClassName: manual and enough capacity to satisfy the PVC's request. Once the PV is created, the PVC will be bound to the PV, and the pod can use the storage.


### Let's explore how dynamic storage provisioning works in Kubernetes.

What is dynamic storage provisioning?

Dynamic storage provisioning is a feature in Kubernetes that allows storage resources to be automatically provisioned and managed by the cluster. This means that when a Persistent Volume Claim (PVC) is created, the cluster will automatically create a Persistent Volume (PV) that meets the requirements specified in the PVC.

How does it work?

Here's a step-by-step overview of how dynamic storage provisioning works:

1. StorageClass creation: A StorageClass is created that defines the type of storage to be provisioned. This StorageClass includes details such as the storage provisioner, parameters, and reclaim policy.
2. PVC creation: A PVC is created that references the StorageClass. The PVC specifies the amount of storage required and the access mode.
3. Dynamic provisioning: When the PVC is created, the cluster's storage provisioner (defined in the StorageClass) is triggered to dynamically provision a PV that meets the requirements specified in the PVC.
4. PV creation: The storage provisioner creates a PV with the requested storage characteristics, such as capacity, access mode, and storage type.
5. Binding: The PVC is bound to the dynamically provisioned PV, and the pod can use the storage provided by the PV.

Example

Let's consider an example where we have a StorageClass named fast-storage that provisions SSD storage. We can create a PVC that references this StorageClass:
```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast-storage
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
```
---
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-fast
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: fast-storage
```
In this example, when the PVC pvc-fast is created, the fast-storage StorageClass will dynamically provision a PV with 1Gi of SSD storage using the kubernetes.io/aws-ebs provisioner. The PV will be bound to the PVC, and the pod can use the storage provided by the PV.

Benefits

Dynamic storage provisioning offers several benefits, including:

- Simplified storage management: Dynamic storage provisioning eliminates the need for manual PV creation and management.
- Increased flexibility: Dynamic storage provisioning allows for more flexible storage management, as storage resources can be provisioned and scaled as needed.
- Improved scalability: Dynamic storage provisioning enables clusters to scale more efficiently, as storage resources can be automatically provisioned to meet growing demands.

Common use cases

Dynamic storage provisioning is commonly used in scenarios where:

- Cloud-based storage: Dynamic storage provisioning is often used in cloud-based environments, where storage resources can be automatically provisioned and scaled.
- Large-scale deployments: Dynamic storage provisioning is useful in large-scale deployments, where manual storage management can become complex and time-consuming.
- Stateful applications: Dynamic storage provisioning is essential for stateful applications that require persistent storage, such as databases and file systems.

### The opposite of dynamic storage provisioning is static storage provisioning.

What is static storage provisioning?

Static storage provisioning involves manually creating and managing Persistent Volumes (PVs) before creating Persistent Volume Claims (PVCs). In other words, the administrator creates the PVs beforehand, specifying the storage characteristics, capacity, and access modes.

How does it work?

Here's a step-by-step overview of static storage provisioning:

1. PV creation: The administrator creates a PV with specific storage characteristics, such as capacity, access mode, and storage type.
2. PVC creation: A PVC is created that references the manually created PV.
3. Binding: The PVC is bound to the manually created PV, and the pod can use the storage provided by the PV.

Use cases

Static storage provisioning is useful in scenarios where:

- Existing storage infrastructure: You have existing storage infrastructure that you want to integrate with your Kubernetes cluster. Static storage provisioning allows you to manually create PVs that reference your existing storage resources.
- Specific storage requirements: Your application requires specific storage characteristics, such as a particular storage type or performance level, that cannot be met by dynamic storage provisioning.
- Legacy systems: You're working with legacy systems that require manual storage management.
- Security and compliance: You need fine-grained control over storage management and provisioning to meet specific security and compliance requirements.

When to use static storage provisioning?

Use static storage provisioning when:

- You have specific storage requirements that cannot be met by dynamic storage provisioning.
- You're working with existing storage infrastructure that you want to integrate with your Kubernetes cluster.
- You need fine-grained control over storage management and provisioning.

Comparison with dynamic storage provisioning

Static storage provisioning provides more control over storage management, but it requires more manual effort and planning. Dynamic storage provisioning, on the other hand, provides more flexibility and scalability, but may not offer the same level of control.

In summary, static storage provisioning is a good fit for scenarios where you need specific control over storage management, while dynamic storage provisioning is suitable for scenarios where you need flexibility and scalability.


### Yes, you can think of the PVC's storage size, access mode, and other specifications as "labels" or "criteria" that are used to match a suitable PV.

When a PVC is created, Kubernetes looks for a PV that matches the PVC's specifications, including:

- Storage size: The PV must have enough capacity to satisfy the PVC's request.
- Access mode: The PV must support the access mode specified in the PVC (e.g., ReadWriteOnce, ReadOnlyMany, etc.).
- Storage class: The PV must have the same storage class as the PVC (if specified).

If a matching PV is found, the PVC is bound to that PV. If no matching PV is found, the PVC remains in a Pending state.

In this sense, you can think of the PVC's specifications as a set of "labels" or "criteria" that are used to select a suitable PV.

Here's a rough analogy:

- PVC = "I need a car with these specifications (storage size, access mode, etc.)"
- PV = "I'm a car with these features (capacity, access mode, etc.)"
- Kubernetes = "Let me find a car (PV) that matches your specifications (PVC)"

When Kubernetes finds a matching PV, it "binds" the PVC to that PV, allowing the pod to use the storage provided by the PV.
