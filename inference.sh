source=cs
target=java
beam_size=10
source_length=320
target_length=256
# output_dir=saved_models/$source-$target/
output_dir=data/$source-$target/replication_results
pretrained_model=microsoft/graphcodebert-base

batch_size=128
dev_file=data/java-cs/valid.java-cs.txt.$source,data/java-cs/valid.java-cs.txt.$target
test_file=data/java-cs/test.java-cs.txt.$source,data/java-cs/test.java-cs.txt.$target
# load_model_path=$output_dir/checkpoint-best-bleu/pytorch_model.bin #checkpoint for test
load_model_path=saved_models/$source-$target/checkpoint-best-bleu/pytorch_model.bin #checkpoint for test
echo "Doing inference from $source to $target"
mkdir -p $output_dir

python run.py \
--do_test \
--model_type roberta \
--source_lang $source \
--model_name_or_path $pretrained_model \
--tokenizer_name microsoft/graphcodebert-base \
--config_name microsoft/graphcodebert-base \
--load_model_path $load_model_path \
--dev_filename $dev_file \
--test_filename $test_file \
--output_dir $output_dir \
--max_source_length $source_length \
--max_target_length $target_length \
--beam_size $beam_size \
--eval_batch_size $batch_size 2>&1| tee $output_dir/test.log