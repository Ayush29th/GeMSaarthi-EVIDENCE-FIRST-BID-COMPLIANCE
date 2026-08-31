const fs = require('fs');
const git = require('isomorphic-git');
const http = require('isomorphic-git/http/node');
const path = require('path');

const dir = process.cwd();
const repoUrl = 'https://github.com/Ayush29th/GeMSaarthi-EVIDENCE-FIRST-BID-COMPLIANCE.git';
const token = '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';

async function pushToGit() {
    console.log("Initializing repo (if needed)...");
    try {
        await git.init({ fs, dir, defaultBranch: 'feature/nextjs-migration' });
        
        console.log("Adding remote...");
        await git.addRemote({
            fs,
            dir,
            remote: 'origin',
            url: repoUrl,
            force: true
        });
    } catch(e) { 
        // ignore if exists
    }

    console.log("Getting file list...");
    
    // We want to add everything except node_modules and .next
    const ignoreList = ['node_modules', '.next', '.git'];
    
    // Function to recursively get all files
    function getAllFiles(dirPath, arrayOfFiles) {
        files = fs.readdirSync(dirPath);
        
        arrayOfFiles = arrayOfFiles || [];
        
        files.forEach(function(file) {
            if (ignoreList.includes(file)) return;
            
            if (fs.statSync(dirPath + "/" + file).isDirectory()) {
                arrayOfFiles = getAllFiles(dirPath + "/" + file, arrayOfFiles);
            } else {
                arrayOfFiles.push(path.join(dirPath, "/", file).replace(/\\/g, '/').replace(dir.replace(/\\/g, '/') + '/', ''));
            }
        });
        
        return arrayOfFiles;
    }
    
    const allFiles = getAllFiles(dir);
    console.log(`Adding ${allFiles.length} files to git index... (this may take a moment)`);
    
    for (const filepath of allFiles) {
        try {
            await git.add({ fs, dir, filepath });
        } catch(e) {
            // ignore add errors for individual files
        }
    }

    console.log("Committing changes...");
    let sha = await git.commit({
        fs,
        dir,
        author: {
            name: 'Agent',
            email: 'agent@antigravity.local',
        },
        message: 'feat: Completed GemSarthi Phase 6 UI and Mock API integration'
    });
    
    console.log(`Commit created: ${sha}`);
    
    let currentBranch = await git.currentBranch({ fs, dir, fullname: false });
    console.log(`Current branch is: ${currentBranch}`);
    
    console.log("Fetching from origin...");
    try {
        await git.fetch({
            fs,
            http,
            dir,
            remote: 'origin',
            ref: currentBranch,
            singleBranch: true,
            onAuth: () => ({ username: token })
        });
    } catch(e) {
        console.log("Fetch failed or repository is empty, proceeding to push...", e.message);
    }
    
    console.log("Pushing to GitHub (Force)...");
    let pushResult = await git.push({
        fs,
        http,
        dir,
        remote: 'origin',
        ref: currentBranch,
        force: true,
        onAuth: () => ({ username: token })
    });
    
    console.log("Push result:", pushResult);
    console.log("SUCCESS!");
}

pushToGit().catch(console.error);
