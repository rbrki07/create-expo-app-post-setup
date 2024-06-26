# create-expo-app-post-setup
A few common setup steps to perform after `create-expo-app` has finished its magic:
* Install `eslint`, `eslint-config-universe`, `eslint-plugin-react-native`, `eslint-plugin-jest` and download a ready-to-use ESLint configuration file. This is based on [Expo's recommendations](https://docs.expo.dev/guides/using-eslint/).
* Install `prettier` and download a ready-to-use Prettier configuration file.
* Install `simple-git-hooks` and configure a simple git pre-commit hook to run eslint and prettier.
* Download VS Code specific configurations files (`extensions.json` and `settings.json`) to ensure ESLint and Prettier will be used as intended.

# Usage

Let's say you created a new Expo project like this:

```shell
npx create-expo-app my-app
```

After that, change into the newly created directory (`cd my-app`) and then just run:

```shell
curl -s "https://raw.githubusercontent.com/rbrki07/create-expo-app-post-setup/main/run.sh" | bash
```

## Further simplification

To save even more time, set an alias.

### Example: Set an alias using ZSH.

```shell
vi ~/.zshrc
```

Add an alias in `~/.zshrc`:

```bash
alias expo-post-setup="curl -s 'https://raw.githubusercontent.com/rbrki07/create-expo-app-post-setup/main/run.sh' | bash"
```

Save and reload `~/.zshrc`:

```shell
source ~/.zshrc
```

Next time just run:
```shell
expo-post-setup
```