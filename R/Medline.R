GetAuthors <- function(object){

	names <- names(object)
	
	first.check <- grep("ForeName",names)
	initial.check <- grep("Initials",names)
	last.index <- grep("LastName",names)
	
	first.index <- last.index+1
	initial.index <- last.index+2
	
	initial.index[!(initial.index%in%initial.check)] <- NA
	first.index[!(first.index%in%first.check)] <- NA

	if(length(last.index)==0){ # NO AUTHORS LISTED
	
	df <- data.frame(
		LastName = NA,
		ForeName = NA,
		Initials = NA
	)

	df$order <- NA
	
	}
	else{
	
	df <- data.frame(
		LastName = as.character(object[last.index]),
		ForeName = as.character(object[first.index]),
		Initials = as.character(object[initial.index]),
		stringsAsFactors=FALSE)

	df$order <- 1:nrow(df)
	
	}
df
}


# # GetAuthors <- function(object){

	# names <- names(object)
	
	# first.index <- grep("ForeName",names)
	# initial.index <- grep("Initials",names)
	# last.index <- grep("LastName",names)
	# lengths <- c(length(first.index),length(initial.index),length(last.index))
	# maxlength <- max(lengths)
	
	# if(any(lengths!=maxlength)){
		# max.index <- which(lengths==maxlength)[1]
		# if(max.index==1){
			# initial.index <- first.index+1
			# last.index <- first.index+2 
		# }
		# else if(max.index==2){
			# first.index <- initial.index-1
			# last.index <- initial.index+1
		# }
		# else{
			# initial.index <- last.index-1
			# first.index <- last.index-2
		# }
	# }
	
	# if(all(lengths==0)){ # NO AUTHORS LISTED
	
	# df <- data.frame(
		# LastName = NA,
		# ForeName = NA,
		# Initials = NA
	# )

	# df$order <- NA

	
	# }
	# else{
	
	# df <- data.frame(
		# LastName = as.character(object[last.index]),
		# ForeName = as.character(object[first.index]),
		# Initials = as.character(object[initial.index]),
		# stringsAsFactors=FALSE)

	# df$order <- 1:nrow(df)
	
	# }
# df
# }

GetMeshMajor <- function(object){

  names <- names(object)

  if(any(names=="DescriptorName")){

    index <- which(names=="DescriptorName")
    index <- min(index):max(index)
    data.frame(
               Heading = object[index],
               Type = ifelse(names[index]=="DescriptorName","Descriptor","Qualifier")
               )
  }
  else
    NA
}


setClass("Medline",
	representation(
			Query = "character",
			PMID = "character",

			YearRevised = "numeric",
            MonthRevised = "numeric",
            DayRevised= "numeric",
	
			YearPubDate = "numeric",
            MonthPubDate = "character",
            DayPubDate= "numeric",
	
			YearArticleDate = "numeric",
            MonthArticleDate = "numeric",
            DayArticleDate= "numeric",

	
			YearEntrez = "numeric",
            MonthEntrez = "numeric",
            DayEntrez= "numeric",
			HourEntrez= "numeric",
			MinuteEntrez= "numeric",           

	
			YearMedline = "numeric",
            MonthMedline = "numeric",
            DayMedline= "numeric",
			HourMedline= "numeric",
			MinuteMedline= "numeric",           
	
			YearReceived = "numeric",
            MonthReceived = "numeric",
            DayReceived= "numeric",
			HourReceived= "numeric",
			MinuteReceived= "numeric",           
			
			YearAccepted = "numeric",
            MonthAccepted = "numeric",
            DayAccepted= "numeric",
			HourAccepted= "numeric",
			MinuteAccepted= "numeric",  

			YearEpublish = "numeric",
            MonthEpublish = "numeric",
            DayEpublish= "numeric",
			HourEpublish= "numeric",
			MinuteEpublish= "numeric",           
			
			YearPpublish = "numeric",
            MonthPpublish = "numeric",
            DayPpublish= "numeric",
			HourPpublish= "numeric",
			MinutePpublish= "numeric",  

			YearPmc = "numeric",
            MonthPmc  = "numeric",
            DayPmc = "numeric",
			HourPmc = "numeric",
			MinutePmc = "numeric",  

			YearPubmed = "numeric",
            MonthPubmed  = "numeric",
            DayPubmed = "numeric",
			HourPubmed = "numeric",
			MinutePubmed = "numeric", 
												 
            Author = "list",
            ISSN= "character",
            Title = "character",
            ArticleTitle= "character",
			ELocationID= "character",
			AbstractText= "character",
			Affiliation= "list",
			Language= "character",
			PublicationType= "list",
			MedlineTA= "character",
			NlmUniqueID= "character",
			ISSNLinking= "character",
			PublicationStatus= "character",
			ArticleId= "character",
			DOI = "character",
			Volume= "character",
			Issue= "character",
			ISOAbbreviation= "character",
			MedlinePgn= "character",
			CopyrightInformation= "character",
			Country= "character",
			GrantID= "character",
			Acronym= "character",
			Agency= "character",
			RegistryNumber= "character",
			RefSource= "character",
			CollectiveName="character",
			COIStatement = "character",
                       	Mesh="list")
)

Medline <- function(object, query = character(0)){
    
    TagIndex <- lapply(object, names)
    
	# ARTICLE LIST FROM PUBMED QUERY
	PMID <- sapply(object, function(x) x["PMID"],USE.NAMES=FALSE)
	
	FUN <- function(index, obj, field) {
		if(any(index == field))
			obj[max(which(index==field))]
		else
			NA
		}

	
	YearRevised <- sapply(object, function(x) x["YearRevised"],USE.NAMES=FALSE)

	MonthRevised <- sapply(object, function(x) x["MonthRevised"],USE.NAMES=FALSE)
	
	DayRevised <- sapply(object, function(x) x["DayRevised"],USE.NAMES=FALSE)

	YearArticleDate <- sapply(object, function(x) x["YearArticleDate"],USE.NAMES=FALSE)
	
	MonthArticleDate <- sapply(object, function(x) x["MonthArticleDate"],USE.NAMES=FALSE)
	
	
	DayArticleDate <- sapply(object, function(x) x["DayArticleDate"],USE.NAMES=FALSE)
	

	YearPubDate <-sapply(object, function(x) x["YearPubDate"],USE.NAMES=FALSE)
	
	MonthPubDate <- sapply(object, function(x) x["MonthPubDate"],USE.NAMES=FALSE)
	
	DayPubDate <- sapply(object, function(x) x["DayPubDate"],USE.NAMES=FALSE)


	YearEntrez <- sapply(object, function(x) x["YearEntrez"],USE.NAMES=FALSE)

	MonthEntrez <- sapply(object, function(x) x["MonthEntrez"],USE.NAMES=FALSE)

	DayEntrez <- sapply(object, function(x) x["DayEntrez"],USE.NAMES=FALSE)

	MinuteEntrez <- sapply(object, function(x) x["MinuteEnrez"],USE.NAMES=FALSE)

	HourEntrez <- sapply(object, function(x) x["HourEntrez"],USE.NAMES=FALSE)


	YearMedline <- sapply(object, function(x) x["YearMedline"],USE.NAMES=FALSE)

	MonthMedline <- sapply(object, function(x) x["MonthMedline"],USE.NAMES=FALSE)

	DayMedline <- sapply(object, function(x) x["DayMedline"],USE.NAMES=FALSE)

	MinuteMedline <- sapply(object, function(x) x["MinuteMedline"],USE.NAMES=FALSE)

	HourMedline <- sapply(object, function(x) x["HourMedline"],USE.NAMES=FALSE)

	YearReceived <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "YearReceived"))
	MonthReceived <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "MonthReceived"))
	DayReceived <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "DayReceived"))
	MinuteReceived <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "MinuteReceived"))
	HourReceived <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "HourReceived"))

	YearEpublish <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "YearEpublish"))
	MonthEpublish <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "MonthEpublish"))
	DayEpublish <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "DayEpublish"))
	MinuteEpublish <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "MinuteEpublish"))
	HourEpublish <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "HourEpublish"))

	YearPpublish <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "YearPpublish"))
	MonthPpublish <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "MonthPpublish"))
	DayPpublish <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "DayPpublish"))
	MinutePpublish <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "MinutePpublish"))
	HourPpublish <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "HourPpublish"))

	YearPmc <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "YearPmc"))
	MonthPmc <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "MonthPmc"))
	DayPmc <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "DayPmc"))
	MinutePmc <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "MinutePmc"))
	HourPmc <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "HourPmc"))

	YearPubmed <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "YearPubmed"))
	MonthPubmed <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "MonthPubmed"))
	DayPubmed <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "DayPubmed"))
	MinutePubmed <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "MinutePubmed"))
	HourPubmed <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "HourPubmed"))


	YearAccepted <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "YearAccepted"))
	MonthAccepted <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "MonthAccepted"))
	DayAccepted <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "DayAccepted"))
	MinuteAccepted <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "MinuteAccepted"))
	HourAccepted <- mapply(FUN, index = TagIndex, obj = object, MoreArgs = list(field = "HourAccepted"))
	
	AbstractCollapse <- function(index, obj, field) {
			matches <- which(index==field)
		paste(obj[matches], collapse = "")
		}	
		
	AbstractText <- mapply(AbstractCollapse, index = TagIndex, obj = object, MoreArgs = list(field = "AbstractText"))
		
	ISSN <- sapply(object, function(x) x["ISSN"],USE.NAMES=FALSE)
	Title <- sapply(object, function(x) x["Title"],USE.NAMES=FALSE)
	ArticleTitle <- sapply(object, function(x) x["ArticleTitle"],USE.NAMES=FALSE)
	ELocationID <- sapply(object, function(x) x["ELocationID"],USE.NAMES=FALSE)
	Affiliation <- lapply(object, function(x) {
		index <- which(names(x) == "Affiliation")
		values <- x[names(x) == "Affiliation"]
		if(length(index) > 1){
			order <- cumsum(c(1, as.numeric(diff(index) > 1)))
			names(values) <- order
			}
		values
		})
	Language <- sapply(object, function(x) x["Language"],USE.NAMES=FALSE)
	PublicationType <- lapply(object, function(x) x[names(x) == "PublicationType"])
	MedlineTA <- sapply(object, function(x) x["MedlineTA"],USE.NAMES=FALSE)
	NlmUniqueID <- sapply(object, function(x) x["NlmUniqueID"],USE.NAMES=FALSE)
	ISSNLinking <- sapply(object, function(x) x["ISSNLinking"],USE.NAMES=FALSE)
	PublicationStatus <- sapply(object, function(x) x["PublicationStatus"],USE.NAMES=FALSE)
	ArticleId <- sapply(object, function(x) x["ArticleId"],USE.NAMES=FALSE)
	DOI <- sapply(object, function(x) x["DOI"],USE.NAMES=FALSE)
	Volume <- sapply(object, function(x) x["Volume"],USE.NAMES=FALSE)
	Issue <- sapply(object, function(x) x["Issue"],USE.NAMES=FALSE)
	ISOAbbreviation <- sapply(object, function(x) x["ISOAbbreviation"],USE.NAMES=FALSE)
	MedlinePgn <- sapply(object, function(x) x["MedlinePgn"],USE.NAMES=FALSE)
	CopyrightInformation <- sapply(object, function(x) x["CopyrightInformation"],USE.NAMES=FALSE)
	Country <- sapply(object, function(x) x["Country"],USE.NAMES=FALSE)
	GrantID <- sapply(object, function(x) x["GrantID"],USE.NAMES=FALSE)
	Acronym <- sapply(object, function(x) x["Acronym"],USE.NAMES=FALSE)
	Agency <- sapply(object, function(x) x["Agency"],USE.NAMES=FALSE)
	RegistryNumber <- sapply(object, function(x) x["RegistryNumber"],USE.NAMES=FALSE)
	RefSource <- sapply(object, function(x) x["RefSource"],USE.NAMES=FALSE)
	CollectiveName <- sapply(object, function(x) x["CollectiveName"],USE.NAMES=FALSE)
	COIStatement <- sapply(object, function(x) x["CoiStatement"],USE.NAMES=FALSE)

    Mesh <- lapply(object, GetMeshMajor)     
	Author <- lapply(object, GetAuthors)
	
	PMID <- as.character(PMID)
	
	YearRevised <- as.numeric(YearRevised)
	MonthRevised <- as.numeric(MonthRevised)
	DayRevised <- as.numeric(DayRevised)
	YearPubDate <- as.numeric(YearPubDate)
	MonthPubDate <- as.character(MonthPubDate)
	DayPubDate <- as.numeric(DayPubDate)
	YearArticleDate <- as.numeric(YearArticleDate)
	MonthArticleDate <- as.numeric(MonthArticleDate)
	DayArticleDate <- as.numeric(DayArticleDate)

	YearEntrez <- as.numeric(YearEntrez)
	MonthEntrez <- as.numeric(MonthEntrez)
	DayEntrez <- as.numeric(DayEntrez)
	HourEntrez <- as.numeric(HourEntrez)
	MinuteEntrez <- as.numeric(MinuteEntrez)
	YearMedline <- as.numeric(YearMedline)
	MonthMedline <- as.numeric(MonthMedline)
	DayMedline <- as.numeric(DayMedline)
	HourMedline <- as.numeric(HourMedline)
	MinuteMedline <- as.numeric(MinuteMedline)
	
	YearAccepted <- as.numeric(YearAccepted)
	YearReceived <- as.numeric(YearReceived)
	YearEpublish <- as.numeric(YearEpublish)
	YearPpublish <- as.numeric(YearPpublish)
	YearPmc <- as.numeric(YearPmc)
	YearPubmed <- as.numeric(YearPubmed)

	MonthAccepted <- as.numeric(MonthAccepted)
	MonthReceived <- as.numeric(MonthReceived)
	MonthEpublish <- as.numeric(MonthEpublish)
	MonthPpublish <- as.numeric(MonthPpublish)
	MonthPmc <- as.numeric(MonthPmc)
	MonthPubmed <- as.numeric(MonthPubmed)

	DayAccepted <- as.numeric(DayAccepted)
	DayReceived <- as.numeric(DayReceived)
	DayEpublish <- as.numeric(DayEpublish)
	DayPpublish <- as.numeric(DayPpublish)
	DayPmc <- as.numeric(DayPmc)
	DayPubmed <- as.numeric(DayPubmed)

	HourAccepted <- as.numeric(HourAccepted)
	HourReceived <- as.numeric(HourReceived)
	HourEpublish <- as.numeric(HourEpublish)
	HourPpublish <- as.numeric(HourPpublish)
	HourPmc <- as.numeric(HourPmc)
	HourPubmed <- as.numeric(HourPubmed)

	MinuteAccepted <- as.numeric(MinuteAccepted)
	MinuteReceived <- as.numeric(MinuteReceived)
	MinuteEpublish <- as.numeric(MinuteEpublish)
	MinutePpublish <- as.numeric(MinutePpublish)
	MinutePmc <- as.numeric(MinutePmc)
	MinutePubmed <- as.numeric(MinutePubmed)

	ISSN <- as.character(ISSN)
	Title <- as.character(Title)
	ArticleTitle <- as.character(ArticleTitle)
	ELocationID <- as.character(ELocationID)
	AbstractText <- as.character(AbstractText)
	Affiliation <- Affiliation
	Language <- as.character(Language)
	PublicationType <- PublicationType
	MedlineTA <- as.character(MedlineTA)
	NlmUniqueID <- as.character(NlmUniqueID)
	ISSNLinking <- as.character(ISSNLinking)
	PublicationStatus <- as.character(PublicationStatus)
	ArticleId <- as.character(ArticleId)
	DOI <- as.character(DOI)
	Volume <- as.character(Volume)
	Issue <- as.character(Issue)
	ISOAbbreviation <- as.character(ISOAbbreviation)
	MedlinePgn <- as.character(MedlinePgn)
	CopyrightInformation <- as.character(CopyrightInformation)
	Country <- as.character(Country)
	GrantID <- as.character(GrantID)
	Acronym <- as.character(Acronym)
	Agency <- as.character(Agency)
	RegistryNumber <- as.character(RegistryNumber)
	RefSource <- as.character(RefSource)
	CollectiveName <- as.character(CollectiveName)
	COIStatement <- as.character(COIStatement)
  	
	new("Medline",
			Query = query,
			PMID = PMID,
			YearRevised = YearRevised, 
		    MonthRevised = MonthRevised , 
		    DayRevised  = DayRevised, 
			YearPubDate = YearPubDate, 
		    MonthPubDate = MonthPubDate , 
		    DayPubDate  = DayPubDate, 
			YearArticleDate = YearArticleDate, 
		    MonthArticleDate = MonthArticleDate , 
		    DayArticleDate  = DayArticleDate, 
			YearEntrez = YearEntrez, 
		    MonthEntrez = MonthEntrez , 
		    DayEntrez  = DayEntrez, 
			HourEntrez = HourEntrez, 
			MinuteEntrez = MinuteEntrez, 	
			YearMedline = YearMedline, 
		    MonthMedline = MonthMedline , 
		    DayMedline  = DayMedline, 
			HourMedline = HourMedline, 
			MinuteMedline = MinuteMedline, 				
			YearAccepted = YearAccepted, 
		    MonthAccepted = MonthAccepted , 
		    DayAccepted  = DayAccepted, 
			HourAccepted = HourAccepted, 
			MinuteAccepted = MinuteAccepted, 	
			YearReceived = YearReceived, 
		    MonthReceived = MonthReceived, 
		    DayReceived  = DayReceived, 
			HourReceived = HourReceived, 
			MinuteReceived = MinuteReceived, 
			YearEpublish = YearEpublish, 
		    MonthEpublish = MonthEpublish , 
		    DayEpublish  = DayEpublish, 
			HourEpublish = HourEpublish, 
			MinuteEpublish = MinuteEpublish, 
			YearPpublish = YearPpublish, 
		    MonthPpublish = MonthPpublish , 
		    DayPpublish  = DayPpublish, 
			HourPpublish = HourPpublish, 
			MinutePpublish = MinutePpublish, 
			YearPmc = YearPmc, 
		    MonthPmc = MonthPmc , 
		    DayPmc  = DayPmc, 
			HourPmc = HourPmc, 
			MinutePmc = MinutePmc, 													    
			YearPubmed = YearPubmed, 
		    MonthPubmed = MonthPubmed , 
		    DayPubmed  = DayPubmed, 
			HourPubmed = HourPubmed, 
			MinutePubmed = MinutePubmed, 											
		    ISSN  = ISSN, 
		    Title  = Title, 
		    Author = Author,
		    ArticleTitle = ArticleTitle, 
			ELocationID = ELocationID, 
			AbstractText = AbstractText, 
			Affiliation = Affiliation, 
			Language = Language, 
			PublicationType = PublicationType, 
			MedlineTA = MedlineTA, 
			NlmUniqueID = NlmUniqueID, 
			ISSNLinking = ISSNLinking, 
			PublicationStatus = PublicationStatus, 
			ArticleId = ArticleId, 
			DOI = DOI, 
			Volume = Volume, 
			Issue = Issue, 
			ISOAbbreviation = ISOAbbreviation, 
			MedlinePgn = MedlinePgn, 
			CopyrightInformation = CopyrightInformation, 
			Country = Country, 
			GrantID = GrantID, 
			Acronym = Acronym, 
			Agency = Agency, 
			RegistryNumber = RegistryNumber, 
			RefSource = RefSource, 
			CollectiveName = CollectiveName,
			COIStatement = COIStatement,
                        Mesh = Mesh
	)
}


setMethod("print","Medline",function(x,...){
		cat("PubMed query: ",x@Query,"\n\n")
		cat("Records: ",length(x@PMID),"\n")
})

setMethod("show","Medline",function(object){
		cat("PubMed query: ",object@Query,"\n\n")
		cat("Records: ",length(object@PMID),"\n")
})

setMethod("Query","Medline",function(object) object@Query)                                
setMethod("PMID","Medline",function(object) object@PMID)                                
setMethod("YearRevised","Medline",function(object) object@YearRevised)                                
setMethod("MonthRevised","Medline",function(object) object@MonthRevised)                              
setMethod("DayRevised","Medline",function(object) object@DayRevised)                                  
setMethod("YearPubDate","Medline",function(object) object@YearPubDate)                                
setMethod("MonthPubDate","Medline",function(object) object@MonthPubDate)                              
setMethod("DayPubDate","Medline",function(object) object@DayPubDate)                                  
setMethod("YearArticleDate","Medline",function(object) object@YearArticleDate)                                
setMethod("MonthArticleDate","Medline",function(object) object@MonthArticleDate)                              
setMethod("DayArticleDate","Medline",function(object) object@DayArticleDate)                                  
setMethod("YearEntrez","Medline",function(object) object@YearEntrez)                                
setMethod("MonthEntrez","Medline",function(object) object@MonthEntrez)                              
setMethod("DayEntrez","Medline",function(object) object@DayEntrez)                                  
setMethod("HourEntrez","Medline",function(object) object@HourEntrez)                                
setMethod("MinuteEntrez","Medline",function(object) object@MinuteEntrez)                            
setMethod("YearMedline","Medline",function(object) object@YearMedline)                                
setMethod("MonthMedline","Medline",function(object) object@MonthMedline)                              
setMethod("DayMedline","Medline",function(object) object@DayMedline)                                  
setMethod("HourMedline","Medline",function(object) object@HourMedline)                                
setMethod("MinuteMedline","Medline",function(object) object@MinuteMedline)                            
setMethod("YearAccepted","Medline",function(object) object@YearAccepted)                                
setMethod("MonthAccepted","Medline",function(object) object@MonthAccepted)                              
setMethod("DayAccepted","Medline",function(object) object@DayAccepted)                                  
setMethod("HourAccepted","Medline",function(object) object@HourAccepted)                                
setMethod("MinuteAccepted","Medline",function(object) object@MinuteAccepted)                            
setMethod("YearReceived","Medline",function(object) object@YearReceived)                                
setMethod("MonthReceived","Medline",function(object) object@MonthReceived)                              
setMethod("DayReceived","Medline",function(object) object@DayReceived)                                  
setMethod("HourReceived","Medline",function(object) object@HourReceived)                                
setMethod("MinuteReceived","Medline",function(object) object@MinuteReceived)  
setMethod("YearEpublish","Medline",function(object) object@YearEpublish)                                
setMethod("MonthEpublish","Medline",function(object) object@MonthEpublish)                              
setMethod("DayEpublish","Medline",function(object) object@DayEpublish)                                  
setMethod("HourEpublish","Medline",function(object) object@HourEpublish)                                
setMethod("MinuteEpublish","Medline",function(object) object@MinuteEpublish)  
setMethod("YearPpublish","Medline",function(object) object@YearPpublish)                                
setMethod("MonthPpublish","Medline",function(object) object@MonthPpublish)                              
setMethod("DayPpublish","Medline",function(object) object@DayPpublish)                                  
setMethod("HourPpublish","Medline",function(object) object@HourPpublish)                                
setMethod("MinutePpublish","Medline",function(object) object@MinutePpublish)  
setMethod("YearPmc","Medline",function(object) object@YearPmc)                                
setMethod("MonthPmc","Medline",function(object) object@MonthPmc)                              
setMethod("DayPmc","Medline",function(object) object@DayPmc)                                  
setMethod("HourPmc","Medline",function(object) object@HourPmc)                                
setMethod("MinutePmc","Medline",function(object) object@MinutePmc)  
setMethod("YearPubmed","Medline",function(object) object@YearPubmed)                                
setMethod("MonthPubmed","Medline",function(object) object@MonthPubmed)                              
setMethod("DayPubmed","Medline",function(object) object@DayPubmed)                                  
setMethod("HourPubmed","Medline",function(object) object@HourPubmed)                                
setMethod("MinutePubmed","Medline",function(object) object@MinutePubmed)  
setMethod("Author","Medline",function(object) object@Author)                            
setMethod("ISSN","Medline",function(object) object@ISSN)                                
setMethod("Title","Medline",function(object) object@Title)                              
setMethod("ArticleTitle","Medline",function(object) object@ArticleTitle)                
setMethod("ELocationID","Medline",function(object) object@ELocationID)                  
setMethod("AbstractText","Medline",function(object) object@AbstractText)                
setMethod("Affiliation","Medline",function(object) object@Affiliation)                  
setMethod("Language","Medline",function(object) object@Language)                        
setMethod("PublicationType","Medline",function(object) object@PublicationType)          
setMethod("MedlineTA","Medline",function(object) object@MedlineTA)                      
setMethod("NlmUniqueID","Medline",function(object) object@NlmUniqueID)                  
setMethod("ISSNLinking","Medline",function(object) object@ISSNLinking)                  
setMethod("PublicationStatus","Medline",function(object) object@PublicationStatus)      
setMethod("ArticleId","Medline",function(object) object@ArticleId)       
setMethod("DOI","Medline",function(object) object@DOI)                
setMethod("Volume","Medline",function(object) object@Volume)                            
setMethod("Issue","Medline",function(object) object@Issue)                              
setMethod("ISOAbbreviation","Medline",function(object) object@ISOAbbreviation)          
setMethod("MedlinePgn","Medline",function(object) object@MedlinePgn)                    
setMethod("CopyrightInformation","Medline",function(object) object@CopyrightInformation)
setMethod("Country","Medline",function(object) object@Country)                          
setMethod("GrantID","Medline",function(object) object@GrantID)                          
setMethod("Acronym","Medline",function(object) object@Acronym)                          
setMethod("Agency","Medline",function(object) object@Agency)                            
setMethod("RegistryNumber","Medline",function(object) object@RegistryNumber)            
setMethod("RefSource","Medline",function(object) object@RefSource)                      
setMethod("CollectiveName","Medline",function(object) object@CollectiveName)            
setMethod("COIStatement","Medline",function(object) object@COIStatement) 
setMethod("Mesh","Medline",function(object) object@Mesh)
setMethod("Cited", "Medline", cited_function)

