# Workflow Housekeeper

[![Test action](https://github.com/JosiahSiegel/workflow-housekeeper/actions/workflows/test_action.yml/badge.svg)](https://github.com/JosiahSiegel/workflow-housekeeper/actions/workflows/test_action.yml)

### Dependencies:

>Change in repo: `Settings -> Actions -> General -> Workflow Permissions to allow read and write`

## Inputs
```yml
  github-token:
    description: 'Token used to login to GitHub'
    required: true
  ignore-branch-workflows:
    description: 'Ignore runs from workflows currently in ./github/workflow'
    required: false
    default: 'false'
```

## Usage
```yml
      - name: Checkout
        uses: actions/checkout@v3
      - name: Run workflow housekeeper
        uses: josiahsiegel/workflow-housekeeper@<CURRENT_VERSION>
```
or
```yml
      - name: Checkout
        uses: actions/checkout@v3
      - name: Run workflow housekeeper
        uses: josiahsiegel/workflow-housekeeper@<CURRENT_VERSION>
        id: scan
        with:
          github-token: ${{ secrets.MY_TOKEN }}
          ignore-branch-workflows: true
```
