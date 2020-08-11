# SCG (Development) Documentation

This is a development repository for the SCG Documentation. The goal is to allow
users to contribute, or easily request bug fixes or additions via [opening an issue](https://github.com/stanford-rc/docs-scg/issues).

## Usage

### 1. Get the code

You can clone the repository right to where you want to host the docs:

```bash
git clone https://github.com/stanford-rc/docs-scg.git docs
cd docs
```

### 2. Customize

The markdown files in [docs](docs) render into the site. We use the default 
[readthedocs](https://mkdocs.readthedocs.io/en/stable/user-guide/styling-your-docs/#readthedocs)
mkdocs theme, with an extra [css file](docs/extra.css) for styling. 

#### How do I add pages?

You can add a new page by writing a new markdown file in [docs](docs).
Navigation can then be found in the [mkdocs.yml](mkdocs.yml). The page is automatically built
and deployed to GitHub pages using a [GitHub workflow](.github/workflows/deploy.yml).

### 3. Serve

You'll need mkdocs installed:

```bash
pip install mkdocs
```

And then you can build locally into a site folder:

```bash
mkdocs build
```

And then cd into the folder, start a local web server to test.

```bash
cd site
python -m http.server 9999
```
