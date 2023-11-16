source=java
target=cs
beam_size=10
source_length=320
target_length=256
output_dir=data/$source-$target/exp_results/
pretrained_model=microsoft/graphcodebert-base

mkdir -p $output_dir

batch_size=64
# dev_file=data/java-cs/valid.java-cs.txt.$source,data/java-cs/valid.java-cs.txt.$target
test_file=data/exps/exp_java2cs.txt.$source,data/exps/exp_java2cs.txt.$target
load_model_path=saved_models/$source-$target/checkpoint-best-bleu/pytorch_model.bin #checkpoint for test

python run.py \
--do_test \
--model_type roberta \
--source_lang $source \
--model_name_or_path $pretrained_model \
--tokenizer_name microsoft/graphcodebert-base \
--config_name microsoft/graphcodebert-base \
--load_model_path $load_model_path \
--test_filename $test_file \
--output_dir $output_dir \
--max_source_length $source_length \
--max_target_length $target_length \
--beam_size $beam_size \
--eval_batch_size $batch_size 2>&1| tee $output_dir/test.log