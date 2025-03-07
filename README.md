# Git-Ahead 🚀

[![Shellcheck](https://github.com/javanile/git-ahead/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/javanile/git-ahead/actions/workflows/shellcheck.yml)

Git-Ahead is a tool that identifies branches 🌿 with commits ahead of the current branch, providing a useful indication of technical debt to manage in a Git repository.

## Installation 🛠️

To install Git-Ahead, you need to clone this repository and ensure you have necessary development tools to run the bash script:

```
git clone https://github.com/javanile/git-ahead.git
cd git-ahead
make install
```

There are no additional dependencies outside of Git.

## Usage 🖥️

To use Git-Ahead, run the provided bash script. Make sure you're on your current branch before running it. Here's an example usage:

```shell
git ahead
```

This will return the list of branches with commits ahead of your current branch like this.

```
TASK3489-login-page            0 | 30
TASK2954-dashboard             8 | 24
TASK4037-user-profile         91 | 6
TASK2697-data-processing     144 | 6
TASK3199-error-handling        0 | 3
TASK3644-logging               8 | 1
TASK3351-testing              38 | 1
TASK3748-documentation       216 | 1
TASK3105-refactoring         229 | 1
```

## Advantages 🌟

- **Identification of Technical Debt**: Getting the list of branches with commits ahead gives a clear indication of technical debt in the Git repository. Branches with more commits might indicate areas of code that require more attention and maintenance.

- **Priority Management**: Knowing which branches have more work in progress can help establish priorities in software development. You can focus efforts on areas of code that require immediate attention.

## DevOps 🛠️

For DevOps professionals, having an overview of updated branches can be extremely useful in managing development and release processes. Knowing branches with commits ahead provides crucial information for assessing project status and planning technical debt management activities.

## Contributing 🤝

Pull requests are welcome. For suggestions and improvements, please open an issue before submitting a pull request.

## License 📝

This project is licensed under the MIT License. See the LICENSE file for details.
