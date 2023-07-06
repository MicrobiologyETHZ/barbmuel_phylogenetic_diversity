library(ape)

tree <- read.tree("data/gtdbtk.bac120.decorated.tree")
leaftree <- keep.tip(tree, which(grepl("Leaf", tree$tip.label)))
leaftree$tip.label <- sub("_.*", "", leaftree$tip.label)

comms <- read.table("data/Mixes_Mini5SynCom.txt", header=T, row.names=1)

divs <- list()
for(i in 2:nrow(comms)){
    strains <- colnames(comms)[which(as.logical(comms[i,]))]
    subtree <- keep.tip(leaftree, which(leaftree$tip.label %in% strains))
    entry <- c(name = rownames(comms)[i], nstrains = length(strains), div = sum(subtree$edge.length))
    divs[[i]] <- entry
}

divs <- as.data.frame(do.call(rbind, divs))
write.table(divs, "data/phylo_divs.txt")
