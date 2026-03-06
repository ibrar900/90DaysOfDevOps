### Task 1: Key-Value Pairs
Create `person.yaml` that describes yourself with:
- `name`
- `role`
- `experience_years`
- `learning` (a boolean)

**Verify:** Run `cat person.yaml` — does it look clean? No tabs?

it look clean no tabs
![screeshot](personyaml.png)

### Task 2: Lists
Add to `person.yaml`:
write using - for tools

tools:
  - linux and shell scripting
  - Neworking
  - git and gitHub
  - docker
  - gitHub actions

write using [] for hobbies

Hobbies: [workout, reading, watching UFC, cooking, traveling, jogging, swimming]

![tools and hobbies](toolsandhobbies.png)

### Task 3: Nested Objects
Create `server.yaml` that describes a server:
 server with nested keys: name, ip, port
database with nested keys: host, name, credentials (nested further: user, password)

**Verify:** Try adding a tab instead of spaces — what happens when you validate it?

![server yaml](serveryaml.png)

### Task 4: Multi-line Strings
In `server.yaml`, add a `startup_script` field using:
1. The `|` block style (preserves newlines)
2. The `>` fold style (folds into one line)

when would use | vs >?
| - is used writing configuration files, multiple commands
> - use when Documentation test and descriptions

![startup script](startupscript.png)

### Task 5: Validate Your YAML
1. Install `yamllint` or use an online validator
2. Validate both your YAML files
3. Intentionally break the indentation — what error do you get?
4. Fix it and validate again

![yamllint](yamllinterror.png)
![yamllint fixed](yamllintfixed.png)

### Task 6: Spot the Difference
Read both blocks and write what's wrong with the second one:
```yaml
# Block 1 - correct
name: devops
tools:
  - docker
  - kubernetes
```
```yaml
# Block 2 - broken
name: devops
tools:
- docker
  - kubernetes
```
 In Block 2 wrong indentation for the kist item kubernetes
'''''
Hints
- YAML is sensitive to indentation — always use spaces, not tabs.
- indentation is everything -- 2 spaces is standard.
- Strings don't need quotes unless they contain special characters (`:`, `#`, etc.)
- `true`/`false` are booleans, `"true"` is a string
- Validate online: yamllint.com
''''
What i learned:
- YAML is a human-readable data serialization format that uses indentation to represent nested structures.
- YAML uses key-value pairs, lists, and nested objects to organize data.
- Lists can be dash (- item) or inline format [item1, item2
- USe -- 2 spaces per level]