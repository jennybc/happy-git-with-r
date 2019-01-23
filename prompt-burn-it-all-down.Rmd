# Burn it all down {#burn}

This is a highly inelegant, but effective technique for disaster recovery.

It has been immortalized in an xkcd comic, so it must be ok:

  * <https://xkcd.com/1597/>
  * <http://explainxkcd.com/wiki/index.php/1597:_Git>

Basic idea:

  * Commit early and often.
  * Push to a remote, like GitHub, often.
  * The state of things on GitHub is your new "worst case scenario".
  * If you really screw things up locally, copy all the files (or the ones that have changed) to a safe place.
    - Usually your files are JUST FINE. But it is easy to goof up the Git infrastructure when you're new at this. And it can be hard to get that straightened out on your own.
  * Rename the existing local repo as a temporary measure, i.e. before you do something radical, like delete it.
  * Clone the repo from GitHub to your local machine. You are back to a happy state.
  * Copy all relevant files back over from your safe space. The ones whose updated state you need to commit.
  * Stage and commit. Push.
  * Carry on with your life.

Practice this before you need it, so you see how it works.

