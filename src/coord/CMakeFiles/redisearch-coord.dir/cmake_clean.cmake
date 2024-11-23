file(REMOVE_RECURSE
  "libredisearch-coord.a"
  "libredisearch-coord.pdb"
)

# Per-language clean rules from dependency scanning.
foreach(lang C CXX)
  include(CMakeFiles/redisearch-coord.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
