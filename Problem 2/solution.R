
imported <- read.table (file="input.txt",
                        header=FALSE , sep=' ', quote='\"', dec=',', fill=TRUE, comment.char="",
                        na.strings = "NA", nrows = -1, skip = 0, check.names = TRUE, strip.white = FALSE, blank.lines.skip = TRUE)

winmatrix = matrix(c(3,0,6,6,3,0,0,6,3),nrow= 3)

shapematrix = matrix(c(1,1,1,2,2,2,3,3,3),nrow= 3)

matrix = shapematrix + winmatrix

colnames(matrix) = c("X","Y","Z")

rownames(matrix) = c("A","B","C")

score = sum(diag(matrix[imported[,1],imported[,2]]))


print(score)

winmatrix = matrix(c(0,0,0,3,3,3,6,6,6),nrow= 3)

usematrix = matrix(c(3,1,2,1,2,3,2,3,1),nrow = 3)

matrix = winmatrix + usematrix

colnames(matrix) = c("X","Y","Z")

rownames(matrix) = c("A","B","C")

score = sum(diag(matrix[imported[,1],imported[,2]]))

print(score)
