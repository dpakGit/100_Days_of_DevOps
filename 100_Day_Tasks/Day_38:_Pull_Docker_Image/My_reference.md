### Docker Tag Command
The docker tag command is used to create a new tag for an existing Docker image. The syntax is:

bash
docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]

- SOURCE_IMAGE: The existing image you want to tag.
- TARGET_IMAGE: The new image name and tag you want to create.

Use of the Command
The docker tag command is useful for:

- Creating aliases: You can create multiple tags for the same image, making it easier to reference the image in different contexts.
- Versioning: You can create tags for different versions of an image, allowing you to easily switch between versions.
- Renaming images: You can rename an existing image by creating a new tag with the desired name.

What Happens After Execution
When you run the docker tag command, Docker creates a new reference to the existing image. The new tag points to the same image ID as the original image.

- No new image is created: The docker tag command does not create a new image; it only creates a new reference to the existing image.
- Image ID remains the same: Both the original and new tags will have the same image ID.

For example:

bash
docker tag busybox:musl busybox:media

This command creates a new tag busybox:media that points to the same image as busybox:musl. Both tags will have the same image ID.


### Docker Command to Show Image ID
To show the Image ID of a Docker image, you can use:

bash
docker images

This command lists all Docker images on your system, including their Image IDs.

Filtering by Image Name
If you want to show the Image ID for a specific image, you can use:

bash
docker images <image_name>

For example:

bash
docker images busybox:musl


Showing Only Image ID
If you want to show only the Image ID without other details, you can use:

bash
docker images -q <image_name>

For example:

bash
docker images -q busybox:musl

The -q flag stands for "quiet" and shows only the numeric IDs.


### Docker Command to Show Image IDs of All Images
To show the Image IDs of all Docker images, use:

bash
docker images -q

**The -q flag stands for "quiet" and displays only the numeric IDs of all images.**

This command will output a list of Image IDs for all Docker images on your system.
