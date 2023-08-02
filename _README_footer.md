## Contact

Atos

to regenerate this `README.md` file run in pwsh, in current directory:

`docker run --rm -v "$($pwd.path):/data" cytopia/terraform-docs terraform-docs-012 -c tfdocs-config.yml ./module`

`docker run --rm --name pre -v "$($pwd.path):/lint" -w /lint ghcr.io/antonbabenko/pre-commit-terraform run -a`

`docker stop pre; docker rm pre; docker run --name pre -v "$($pwd.path):/lint" -w /lint ghcr.io/antonbabenko/pre-commit-terraform run -a`
