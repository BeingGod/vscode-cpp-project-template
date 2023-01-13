#!/bin/bash
set -e

project_name=$1
if [[ -z $project_name ]]; then
  echo "Useage: ./scripts/init_project.sh"
  exit 1
fi

echo "Init $project_name project..."

current_dir=$(cd `dirname $0`; pwd)
project_dir=$current_dir/../..

mkdir -p $project_dir/.vscode
mkdir -p $project_dir/build

cp $current_dir/../CMakePresets.json $project_dir
cp $current_dir/../.vscode/extensions.json $project_dir/.vscode
cp $current_dir/../.vscode/settings.json $project_dir/.vscode
cp $current_dir/../.vscode/tasks.json $project_dir/.vscode
cp $current_dir/../.clang-format $project_dir

echo "$(cat $current_dir/../.vscode/launch.json | sed "s/<project>/${project_name}/g")" >  $project_dir/.vscode/launch.json
echo "$(cat $current_dir/android_lldb_start.sh | sed "s/<project>/${project_name}/g")" >  $project_dir/build/android_lldb_start.sh

cd $project_dir

echo "Finished init $project_name project, you can delete vscode-cpp-project-template !"
