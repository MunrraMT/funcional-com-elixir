# MAPS
abc = %{e: 1, f: 4}

%{abc | f: 5}
# %{e: 1, f: 5}
# ab = %{e: 1, f: 4}

abc = %{abc | f: 10}
# %{e: 1, f: 10}
