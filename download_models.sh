echo "Downloading models..."

mkdir -p saved_models/java-cs/checkpoint-best-bleu/
mkdir -p saved_models/cs-java/checkpoint-best-bleu/

echo "Downloading java-cs model..."
gdown --id 1LkdjvbgoJszjeJEI9TOy6cTFzPu9yjwZ
mv pytorch_model.bin saved_models/java-cs/checkpoint-best-bleu/
echo "java-cs model downloaded at saved_models/java-cs/checkpoint-best-bleu/"

echo "Downloading cs-java model..."
gdown --id 1JMMpbW_stCo74XEJeufGO_prJdQFYw4U
mv pytorch_model.bin saved_models/cs-java/checkpoint-best-bleu/
echo "cs-java model downloaded at saved_models/cs-java/checkpoint-best-bleu/"