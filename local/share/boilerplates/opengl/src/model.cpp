#include <glad/glad.h>
#include <GLFW/glfw3.h>

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>

#include <assimp/Importer.hpp>
#include <assimp/scene.h>
#include <assimp/postprocess.h>

#include <iostream>
#include <vector>
#include <string>
#include <map>

#include "model.h"
#include "mesh.h"
#include "shader.h"

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

std::map<std::string, std::vector<Mesh>> Model::loadedMeshes;

Model::Model(std::string path)
{
	if (loadedMeshes.count(path) == 0)
		loadModel(path);
	else
		meshes = loadedMeshes[path];

	translation = glm::mat4(1.0f);
	rotation = glm::mat4(1.0f);
	scale = glm::mat4(1.0f);
	updateModelMatrix();
}

void Model::render(Shader shader)
{
	shader.use();
	shader.setMat4("model", model);

	for (Mesh m : meshes)
		m.draw(shader);
}

void Model::loadModel(std::string path)
{
	Assimp::Importer importer;
	const aiScene *scene = importer.ReadFile(path, aiProcess_Triangulate | aiProcess_FlipUVs);

	if (!scene || scene->mFlags & AI_SCENE_FLAGS_INCOMPLETE || !scene ->mRootNode) {
		std::cerr << "ERROR::ASSIMP::" << importer.GetErrorString() << std::endl;
		return;
	}

	directory = path.substr(0, path.find_last_of('/'));

	processNode(scene->mRootNode, scene);

	loadedMeshes[path] = meshes;
}

void Model::processNode(aiNode* node, const aiScene *scene)
{
	for (unsigned int i = 0; i < node->mNumMeshes; i++)
		meshes.push_back(processMesh(scene->mMeshes[node->mMeshes[i]], scene));

	for (unsigned int i = 0; i < node->mNumChildren; i++)
		processNode(node->mChildren[i], scene);
}

Mesh Model::processMesh(aiMesh* mesh, const aiScene *scene)
{
	std::vector<Vertex> vertices;
	std::vector<unsigned int> indices;
	std::vector<Texture> textures;

	// Vertices
	for (unsigned int i = 0; i < mesh->mNumVertices; i++) {

		aiVector3D position = mesh->mVertices[i];
		aiVector3D normal = mesh->mNormals[i];

		vertices.push_back({
			glm::vec3(position.x, position.y, position.z),
			glm::vec3(normal.x, normal.y, normal.z),
			mesh->mTextureCoords[0]
				? glm::vec2(mesh->mTextureCoords[0][i].x, mesh->mTextureCoords[0][i].y) \
				: glm::vec2(0.0f, 0.0f),
		});
	}

	// Indices
	for (unsigned int i = 0; i < mesh->mNumFaces; i++) {
		aiFace* face = &mesh->mFaces[i];
		for (unsigned int j = 0; j < face->mNumIndices; j++)
			indices.push_back(face->mIndices[j]);
	}

	// Material textures
	if (mesh->mMaterialIndex >= 0) {

		aiMaterial *mat = scene->mMaterials[mesh->mMaterialIndex];
		std::vector<Texture> diffuseMaps, specularMaps;

		diffuseMaps = loadMaterialTextures(mat, aiTextureType_DIFFUSE, "texture_diffuse");
		textures.insert(textures.end(), diffuseMaps.begin(), diffuseMaps.end());

		specularMaps = loadMaterialTextures(mat, aiTextureType_SPECULAR, "texture_specular");
		textures.insert(textures.end(), specularMaps.begin(), specularMaps.end());
	}

	return Mesh(vertices, indices, textures);

}

std::vector<Texture> Model::loadMaterialTextures(aiMaterial *mat, aiTextureType type, std::string typeName)
{
	std::vector<Texture> textures;

	for (unsigned int i = 0; i < mat->GetTextureCount(type); i++) {

		aiString pathname_;
		mat->GetTexture(type, i, &pathname_);
		const char* pathname = pathname_.C_Str();

		bool loaded = false;
		for (auto loadedTexture : loadedTextures) {
			if (loaded = (std::strcmp(loadedTexture.pathname, pathname))) {
				textures.push_back(loadedTexture);
				break;
			}
		}

		if (!loaded) {
			Texture tex = {
				loadTextureFromFile(this->directory + '/' + pathname),
				typeName,
				pathname,
			};
			textures.push_back(tex);
			loadedTextures.push_back(tex);
		}
	}

	return textures;
}

void Model::translate(float dx, float dy, float dz)
{
	translate(glm::vec3(dx, dy, dz));
}

void Model::translate(glm::vec3 dp)
{
	translation = glm::translate(translation, dp);
	updateModelMatrix();
}

void Model::rotate(float ax, float ay, float az)
{
	if (ax)
		rotation = glm::rotate(rotation, glm::radians(ax), glm::vec3(1.0f, 0.0f, 0.0f));
	if (ay)
		rotation = glm::rotate(rotation, glm::radians(ay), glm::vec3(0.0f, 1.0f, 0.0f));
	if (az)
		rotation = glm::rotate(rotation, glm::radians(az), glm::vec3(0.0f, 0.0f, 1.0f));
	updateModelMatrix();
}

void Model::rescale(float ds)
{
	scale = glm::scale(scale, glm::vec3(ds));
	updateModelMatrix();
}

void Model::updateModelMatrix()
{
	model = translation * rotation * scale;
}


unsigned int loadTextureFromFile(const std::string filename)
{
	unsigned int textureID;
	glGenTextures(1, &textureID);

	int width, height, nrComponents;

	unsigned char *data = stbi_load(filename.c_str(), &width, &height, &nrComponents, 0);

	if (!data) {
		std::cerr << "Texture failed to load at path: " << filename << std::endl;
		return 0;
	}

	GLenum format;
	if (nrComponents == 1)
		format = GL_RED;
	else if (nrComponents == 3)
		format = GL_RGB;
	else if (nrComponents == 4)
		format = GL_RGBA;


	glBindTexture(GL_TEXTURE_2D, textureID);
	glTexImage2D(GL_TEXTURE_2D, 0, format, width, height, 0, format, GL_UNSIGNED_BYTE, data);
	glGenerateMipmap(GL_TEXTURE_2D);

	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

	stbi_image_free(data);

	return textureID;
}
