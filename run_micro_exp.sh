#!/bin/bash

# Define the base parameters
beam_size=10
source_length=320
target_length=256
pretrained_model=microsoft/graphcodebert-base
base_output_dir=data/exps/micro_exp_results
model_dir=saved_models
batch_size=64
evaluation_script="evaluation/pl_eval.py"

# Define the experiment types
# declare -a experiments=("easy" "medium" "hard" "non_class_or_function" "has_class_or_function")
declare -a experiments=("easy")

# Define the source and target languages for the loop
declare -a languages=("cs-java" "java-cs")

echo "Starting automated experiments..."

# Loop over the language pairs
for lang_pair in "${languages[@]}"; do
    # Extract source and target languages from the language pair
    IFS='-' read -ra ADDR <<< "$lang_pair"
    source=${ADDR[0]}
    target=${ADDR[1]}

    # Output language-specific setup
    # echo "Running experiments for $source to $target"

    # Loop over the experiments
    for exp in "${experiments[@]}"; do
        # Define the output directory
        output_dir="$base_output_dir/$exp/$source-$target/"
        mkdir -p $output_dir

        # Define the test file
        # test_file="data/exps/$exp_java2cs.txt.$source,data/exps/$exp_java2cs.txt.$target"

        source_file="data/exps/$exp.$source"
        target_file="data/exps/$exp.$target"
        test_file="$source_file,$target_file"

        # Define the model load path
        load_model_path="$model_dir/$source-$target/checkpoint-best-bleu/pytorch_model.bin" #checkpoint for test

        echo "Running experiment $exp for $source to $target"
        echo "Test file: $test_file"
        echo "Output directory: $output_dir"

        # Execute the experiment
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
        --eval_batch_size $batch_size 2>&1 | tee "$output_dir/test.log"

        # Run the evaluation script after the experiment
        gold_path="$output_dir/test_0.gold"
        output_path="$output_dir/test_0.output"
        metrics_output="$output_dir/${exp}_all_metrics.txt"

        # Run the evaluation script
        # --lang should be the target language, which is java if $target is java and c_sharp if $target is cs
        eval_lang=$target
        if [ "$target" = "cs" ]; then
            eval_lang="c_sharp"
        fi

        python $evaluation_script \
        --references $gold_path \
        --predictions $output_path \
        --lang $eval_lang \
        --output $metrics_output

    done
done

echo "All experiments completed!"