docker build . --build-arg BASE_IMAGE=archlinux/archlinux:base-20260729.0.563736 -t nvim:latest && docker run --name nvim-playground --rm -it nvim:latest zsh
