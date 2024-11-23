file(REMOVE_RECURSE
  "redisearch.pdb"
  "redisearch.so"
)

# Per-language clean rules from dependency scanning.
foreach(lang C)
  include(CMakeFiles/redisearch.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
