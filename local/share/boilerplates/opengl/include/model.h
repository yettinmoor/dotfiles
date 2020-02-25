#pragma once

#include <glad/glad.h>
#include <GLFW/glfw3.h>

#include <glm/glm.hpp>

#include <assimp/Importer.hpp>
#include <assimp/scene.h>
#include <assimp/postprocess.h>

#include <vector>
#include <string>
#include <map>

#include "mesh.h"
#include "shader.h"

class Model {

	public:
		Model(std::string path);

		void translate(float dx, float dy, float dz);
		void translate(glm::vec3 dp);
		void rotate(float ax, float ay, float az);
		void rescale(float scale);
		void render(Shader shader);

	private:
		static std::map<std::string, std::vector<Mesh>> loadedMeshes;

		std::vector<Mesh> meshes;
		std::vector<Texture> loadedTextures;
		std::string directory;

		void loadModel(std::string path);
		void processNode(aiNode* node, const aiScene *scene);
		Mesh processMesh(aiMesh* mesh, const aiScene *scene);
		std::vector<Texture> loadMaterialTextures(aiMaterial *mat, aiTextureType type, std::string typeName);

		glm::mat4 model;
		glm::mat4 translation;
		glm::mat4 rotation;
		glm::mat4 scale;

		void updateModelMatrix();
};

unsigned int loadTextureFromFile(const std::string filename);
