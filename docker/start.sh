if [ "$OPTIMIZER" == "FasterTransformer" ]; then
  echo "==Loading FasterTransformer=="
  [ ! -f /workspace/FasterTransformer/build/gemm_config.in ] && cd /workspace/FasterTransformer/build && ./bin/gpt_gemm 1 1 128 96 128 49152 150528 1 8
else
  echo "==No OPTIMIZER=="
fi
cd /workspace/FasterTransformer/build && bash ../examples/pytorch/glm/glm_server.sh