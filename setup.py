# Source: https://packaging.python.org/tutorials/packaging-projects/

from setuptools import setup, find_packages

with open("README.md", "r") as f:
    long_desc = f.read()

setup(
    name="package_name",
    version="0.0.1",
    author="",
    author_email="",
    description="",
    long_description=long_desc,
    long_description_content_type="text/markdown",
    url="",
    packages=find_packages(),
    python_requires=">=3.6"
)
