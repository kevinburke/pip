#!/bin/bash
set -e
set -x

# This is required in order to get UTF-8 output inside of the subprocesses that
# our tests use.
export LC_CTYPE=en_US.UTF-8

# Run the unit tests
tox -- -m unit --cov pip/ --cov-report xml

# Run our integration tests, typically with pytest-xdist to speed things up
# except on Python 3.2 where it doesn't work quite right.
case $TOXENV in
    py32)
        tox -- -m integration
        ;;
    *)
        tox -- -m integration
        ;;
esac


if [[ $TRAVIS_PULL_REQUEST != "false" ]]
then
    # If this is a pull request then run our diff-cover to get the difference
    # in coverage that this PR introduces
    if [ -f coverage.xml ]
    then
        git fetch origin $TRAVIS_BRANCH:refs/remotes/origin/$TRAVIS_BRANCH
        diff-cover --compare-branch=origin/$TRAVIS_BRANCH coverage.xml
    fi
else
    # If this is not a PR, but is being run against a branch, then just report
    # the coverage results for the entire code base.
    if [ -f .coverage ]
    then
        coverage report -m
    fi
fi
