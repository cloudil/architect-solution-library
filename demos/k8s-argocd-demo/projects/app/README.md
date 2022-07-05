# Build pipeline for ArgoCD Image Updater integration

## How it works

* Feature

```bash
make some changes in code
git add .
git commit -m "commit message"
git push
```

Results in
`cr.cloudil.com`

* Release

```bash
git tag 0.1.0
git push --tags
```

Results in
`cr.cloudil.com`

