# 📍 Vim Marks Complete Guide

## What Are Marks?
Marks are **bookmarks** in your code that let you quickly jump to specific lines or positions. Think of them as saved cursor positions you can instantly return to.

## 🎯 How to Use Marks

### **1. Setting Marks**
| Command | Description | Example |
|---------|-------------|---------|
| `ma` | Set mark 'a' at current line | Position cursor, press `ma` |
| `mb` | Set mark 'b' at current line | Position cursor, press `mb` |
| `mA` | Set global mark 'A' (works across files) | Position cursor, press `mA` |
| `m1` | Set numbered mark 1-9 | Position cursor, press `m1` |

### **2. Jumping to Marks**
| Command | Description | Example |
|---------|-------------|---------|
| `'a` | Jump to **line** with mark 'a' | Press `'a` |
| `` `a `` | Jump to **exact position** (line + column) of mark 'a' | Press `` `a `` |
| `'A` | Jump to global mark 'A' (across files) | Press `'A` |
| `'1` | Jump to numbered mark 1 | Press `'1` |

### **3. Removing Marks** ✨ NEW INTUITIVE WAY!
| Command | Description | Example |
|---------|-------------|---------|
| `dma` | Delete mark 'a' | Press `d`, then `m`, then `a` |
| `dmb` | Delete mark 'b' | Press `d`, then `m`, then `b` |
| `dmA` | Delete global mark 'A' | Press `d`, then `m`, then `A` |
| `<leader>dm` | Delete ALL marks in current buffer | Press space, then `d`, then `m` |

### **4. Viewing Marks**
| Command | Description |
|---------|-------------|
| `<leader>sm` | Show all marks (list them) |
| `:marks` | Show marks (vim command) |

## 🔥 Real-World Examples

### **Example 1: Navigating Between Functions**
```
1. Go to main() function → press `mm` (set mark 'm' for main)
2. Go to helper() function → press `mh` (set mark 'h' for helper)  
3. Go to error handling → press `me` (set mark 'e' for error)
4. Jump back to main → press `'m`
5. Jump to helper → press `'h`
6. Jump to error → press `'e`
```

### **Example 2: Cross-File Navigation (Global Marks)**
```
1. In config.go → press `mC` (global mark 'C' for config)
2. In main.go → press `mM` (global mark 'M' for main)
3. In utils.go → press `mU` (global mark 'U' for utils)
4. From anywhere → press `'C` to jump to config.go
5. From anywhere → press `'M` to jump to main.go
```

### **Example 3: Cleaning Up Marks**
```
1. See all marks → press `<leader>sm`
2. Remove specific mark → press `dma` (deletes mark 'a')
3. Remove all marks → press `<leader>dm`
```

## 📚 Mark Types

### **Local Marks** (lowercase a-z)
- **Scope**: Current buffer/file only
- **Usage**: `ma`, `mb`, `mc`, etc.
- **Best for**: Navigating within a single file

### **Global Marks** (uppercase A-Z)
- **Scope**: Works across all files
- **Usage**: `mA`, `mB`, `mC`, etc.
- **Best for**: Navigating between different files

### **Numbered Marks** (0-9)
- **Scope**: Special numbered positions
- **Usage**: `m1`, `m2`, `m3`, etc.
- **Best for**: Temporary bookmarks

## 💡 Pro Tips

### **Naming Convention Suggestions:**
- `mm` → **m**ain function
- `mf` → **f**unction you're working on
- `me` → **e**rror handling section
- `mt` → **t**est section
- `mC` → **C**onfig file (global)
- `mM` → **M**ain file (global)
- `mT` → **T**est file (global)

### **Workflow Examples:**

**For Go Development:**
```bash
# In main.go
mm    # Mark main function
mh    # Mark HTTP handlers
mdb   # Mark database code

# In config.go  
mC    # Global mark for config

# Quick navigation
'mm   # Jump to main
'h    # Jump to handlers
'C    # Jump to config file
```

**For Debugging:**
```bash
mb    # Mark where bug occurs
mf    # Mark function causing issue
ml    # Mark line you're investigating

# After fixing
dmb   # Delete bug mark
dmf   # Delete function mark
dml   # Delete line mark
```

## 🚀 Advanced Usage

### **Combine with Other Commands:**
- `d'a` → Delete from current position to mark 'a'
- `y'a` → Yank from current position to mark 'a'  
- `='a` → Auto-indent from current position to mark 'a'

### **Mark + Search:**
1. Set mark before searching: `ma`
2. Search: `/something`
3. If not found, return: `'a`

### **Mark + Edit:**
1. Mark start of function: `ma`
2. Go to end of function
3. Select entire function: `v'a`

## 🔧 Troubleshooting

### **"Mark not set" Error:**
- You haven't set that mark yet
- Use `<leader>sm` to see existing marks

### **Can't Find Mark:**
- Local marks (a-z) only work in same file
- Use global marks (A-Z) for cross-file navigation

### **Too Many Marks:**
- Clean up: `<leader>dm` (delete all)
- Or remove specific ones: `dma`, `dmb`, etc.

## 📖 Quick Reference Card

```
SET MARKS:           JUMP TO MARKS:       DELETE MARKS:
ma, mb, mc...        'a, 'b, 'c...       dma, dmb, dmc...
mA, mB, mC...        'A, 'B, 'C...       dmA, dmB, dmC...
m1, m2, m3...        '1, '2, '3...       dm1, dm2, dm3...

UTILITIES:
<leader>sm  → Show all marks
<leader>dm  → Delete all marks
:marks      → Show marks (vim command)
```

---

**Remember**: The `dm` + letter pattern is **custom** - this makes mark removal as intuitive as mark setting!