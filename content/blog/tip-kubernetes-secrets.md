---
title: '💡 Tip: Never Store Secrets in Kubernetes ConfigMaps'
date: 2025-11-30
draft: false
tags: ['tip', 'kubernetes', 'security']
summary: 'Quick security tip for Kubernetes deployments'
type: 'tip'
---

**The Problem:** I have seen teams store database passwords and API keys in ConfigMaps because they are easier to work with than Secrets.

**Why it is dangerous:** ConfigMaps are stored in plain text in etcd. Anyone with read access to the namespace can see them. They are meant for non-sensitive config only.

**The Right Way:**
- Use Kubernetes Secrets (base64 encoded, access-controlled)
- Better yet: External secrets management (AWS Secrets Manager, HashiCorp Vault)
- Enable encryption at rest for etcd

**Quick Win:** Audit your ConfigMaps right now with:
```bash
kubectl get configmaps -A -o json | grep -i "password\|token\|key"
```

If you find secrets, migrate them immediately.

---