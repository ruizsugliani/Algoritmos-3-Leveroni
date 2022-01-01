!classDefinition: #TestSF1 category: 'ServiciosFinancieros-2'!
TestCase subclass: #TestSF1
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-2'!
TestSF1 subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 11/29/2021 18:55:37'!
test12PortfolioCanNotIncludeItself

	| simplePortfolio |
	
	simplePortfolio := Portfolio new.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 0 equals: simplePortfolio accountsSize. ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-2'!
TestSF1 subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-2'!
TestSF1 subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #TestSF2 category: 'ServiciosFinancieros-2'!
TestCase subclass: #TestSF2
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!


!classDefinition: #AccountSummaryTest category: 'ServiciosFinancieros-2'!
TestSF2 subclass: #AccountSummaryTest
	instanceVariableNames: 'firstAccount secondAccount portfolio emptyExpectedResult depositExpectedResult withdrawExpectedResult transferWithdrawExpectedResult transferDepositExpectedResult'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!AccountSummaryTest methodsFor: 'test' stamp: 'LG 12/3/2021 17:07:00'!
setUp

	firstAccount := ReceptiveAccount new.	
	
	secondAccount := ReceptiveAccount new.
	
	portfolio := Portfolio with: firstAccount.
	
	emptyExpectedResult := OrderedCollection with: 'Balance = 0 * pesos'.
	
	depositExpectedResult := OrderedCollection with: 'Deposito por 100 * pesos' with: 'Balance = 100 * pesos'.
	
	withdrawExpectedResult := OrderedCollection with: 'Extraccion por 50 * pesos' with: 'Balance = -50 * pesos'.
	
	transferWithdrawExpectedResult := OrderedCollection 	with: 'Salida por transferencia de 20 * pesos' with: 'Balance = -20 * pesos'.
	
	transferDepositExpectedResult := OrderedCollection with: 'Entrada por transferencia de 30 * pesos' with: 'Balance = 30 * pesos'.! !

!AccountSummaryTest methodsFor: 'test' stamp: 'SRS 12/6/2021 17:03:01'!
test01AnAccountWithoutMovementsHasOnlyBalanceInAccountSummary
	
	self assert: emptyExpectedResult equals: (AccountSummary of: firstAccount) generate.! !

!AccountSummaryTest methodsFor: 'test' stamp: 'SRS 12/6/2021 17:03:01'!
test02AnAccountWithDepositHasOnlyDepositInAccountSummary
	
	Deposit register: 100 * peso on: firstAccount. 
	
	self assert: depositExpectedResult equals: (AccountSummary of: firstAccount) generate.! !

!AccountSummaryTest methodsFor: 'test' stamp: 'SRS 12/6/2021 17:03:01'!
test03AnAccountWithWithdrawHasOnlyWithdrawInAccountSummary

	Withdraw register: 50 * peso on: firstAccount.
	
	self assert: withdrawExpectedResult equals: (AccountSummary of: firstAccount) generate.! !

!AccountSummaryTest methodsFor: 'test' stamp: 'SRS 12/6/2021 17:03:01'!
test04AnAccountWithTransferWithdrawHasOnlyTransferWithdrawInAccountSummary

	Transfer amount: 20 * peso from: firstAccount to: secondAccount.
	
	self assert: transferWithdrawExpectedResult equals: (AccountSummary of: firstAccount) generate.! !

!AccountSummaryTest methodsFor: 'test' stamp: 'SRS 12/6/2021 17:03:01'!
test05AnAccountWithTransferDepositHasOnlyTransferDepositInAccountSummary

	Transfer amount: 30 * peso from:  secondAccount to: firstAccount.
	
	self assert: transferDepositExpectedResult equals: (AccountSummary of: firstAccount) generate.! !


!classDefinition: #PortfolioDetailedTreePrinterTest category: 'ServiciosFinancieros-2'!
TestSF2 subclass: #PortfolioDetailedTreePrinterTest
	instanceVariableNames: 'familyPortfolio expectedResult01 expectedResult02 expectedResult03 expectedResult04 johnsAccount angiesAccount childrenPortfolio myAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!PortfolioDetailedTreePrinterTest methodsFor: 'test' stamp: 'SRS 12/4/2021 22:37:40'!
setUp
	
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	
	expectedResult01 := OrderedCollection new. 
	expectedResult01 add: 'Portfolio de la familia'.
	expectedResult01 add: '   Balance = 0 * pesos'.
	
	expectedResult02 := OrderedCollection new.
	expectedResult02 add: 'Portfolio de la familia'.
	expectedResult02 add: '   Cuenta mia'.
	expectedResult02 add: '      Deposito por 100 * pesos'.
	expectedResult02 add: '      Balance = 100 * pesos'.	
	expectedResult02 add: '   Balance = 100 * pesos'.
	
	expectedResult03 := OrderedCollection new.
	expectedResult03 add: 'Portfolio de la familia'.
	expectedResult03 add: '   Portfolio de hijos'. 
	expectedResult03 add: '      Cuenta de Juan'. 
	expectedResult03 add: '         Deposito por 100 * pesos'.
	expectedResult03 add: '         Balance = 100 * pesos'.
	expectedResult03 add: '      Balance = 100 * pesos'.
	expectedResult03 add: '   Balance = 100 * pesos'.
	
	expectedResult04 := OrderedCollection new.
	expectedResult04 add: 'Portfolio de la familia'.
	expectedResult04 add: '   Cuenta mia'.
	expectedResult04 add: '      Deposito por 100 * pesos'.
	expectedResult04 add: '      Extraccion por 40 * pesos'.
	expectedResult04 add: '      Salida por transferencia de 50 * pesos'.
	expectedResult04 add: '      Balance = 10 * pesos'.
	expectedResult04 add: '   Portfolio de hijos'. 
	expectedResult04 add: '      Cuenta de Juan'. 
	expectedResult04 add: '         Deposito por 100 * pesos'.
	expectedResult04 add: '         Extraccion por 30 * pesos'.
	expectedResult04 add: '         Balance = 70 * pesos'.
	expectedResult04 add: '      Cuenta de Angeles'.
	expectedResult04 add: '         Entrada por transferencia de 50 * pesos'.
	expectedResult04 add: '         Balance = 50 * pesos'.
	expectedResult04 add: '      Balance = 120 * pesos'.
	expectedResult04 add: '   Balance = 130 * pesos'.! !

!PortfolioDetailedTreePrinterTest methodsFor: 'test' stamp: 'SRS 12/6/2021 17:03:01'!
test01PorfolioDetailedTreePrinterOfEmptyPortfolio

	familyPortfolio := Portfolio named: 'Portfolio de la familia'.
	
	self assert: expectedResult01 equals: (DetailedTreePrinter of: familyPortfolio) generate.
	
	! !

!PortfolioDetailedTreePrinterTest methodsFor: 'test' stamp: 'SRS 12/6/2021 17:03:01'!
test02PortfolioDetailedPrinterOfPortfolioWithAnAccount

	Deposit register: 100 * peso on: myAccount.
	
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount.
	
	self assert: expectedResult02 equals: (DetailedTreePrinter of: familyPortfolio) generate..! !

!PortfolioDetailedTreePrinterTest methodsFor: 'test' stamp: 'SRS 12/6/2021 17:03:01'!
test03PortfolioDetailedTreePrinterOfPorfolioWithPortfolioAndAnAccountLinkedToThatLastPortfolio
	
	Deposit register: 100 * peso on: johnsAccount.
	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount.
	
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: childrenPortfolio.
	
	self assert: expectedResult03 equals: (DetailedTreePrinter of: familyPortfolio) generate.! !

!PortfolioDetailedTreePrinterTest methodsFor: 'test' stamp: 'SRS 12/6/2021 17:03:01'!
test04PortfolioDetailedTreePrinterOfPorfolioWithAccountAndPortfolio
	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount. 
	
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	Deposit register: 100 * peso on: myAccount.
	Withdraw register: 40 * peso on: myAccount.
	Transfer amount: 50 * peso from: myAccount to: angiesAccount.
	
	Deposit register: 100 * peso on: johnsAccount.
	Withdraw register: 30 * peso on: johnsAccount.
	
	self assert: expectedResult04 equals: (DetailedTreePrinter of: familyPortfolio) generate.! !


!classDefinition: #PortfolioTreePrinterTest category: 'ServiciosFinancieros-2'!
TestSF2 subclass: #PortfolioTreePrinterTest
	instanceVariableNames: 'familyPortfolio expectedResult01 expectedResult02 expectedResult03 expectedResult04 johnsAccount angiesAccount childrenPortfolio myAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!PortfolioTreePrinterTest methodsFor: 'test' stamp: 'SRS 12/4/2021 22:16:28'!
setUp
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.	
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	
	expectedResult01 := OrderedCollection new.
	expectedResult01 add: 'Portfolio de la familia'.
	
	expectedResult02 := OrderedCollection new.
	expectedResult02 add: 'Portfolio de la familia'.
	expectedResult02 add: '   Cuenta mia'.
	
	expectedResult03 := OrderedCollection new.
	expectedResult03 add: 'Portfolio de la familia'.
	expectedResult03 add: '   Cuenta mia'.
   	expectedResult03 add: '   Portfolio de hijos'.
	
	expectedResult04 := OrderedCollection new.
	expectedResult04 add: 'Portfolio de la familia'.
	expectedResult04 add: '   Cuenta mia'.
	expectedResult04 add: '   Portfolio de hijos'.
	expectedResult04 add: '      Cuenta de Juan'.
	expectedResult04 add: '      Cuenta de Angeles'.! !

!PortfolioTreePrinterTest methodsFor: 'test' stamp: 'SRS 12/6/2021 17:03:01'!
test01PorfolioTreePrinterOfEmptyPortfolio
	
	familyPortfolio := Portfolio named: 'Portfolio de la familia'.
	
	self assert: expectedResult01 equals: (TreePrinter of: familyPortfolio) generate. ! !

!PortfolioTreePrinterTest methodsFor: 'test' stamp: 'SRS 12/6/2021 17:03:01'!
test02PortfolioTreePrinterOfPortfolioWithReceptiveAccount	

	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount .
	
	self assert: expectedResult02 equals: (TreePrinter of: familyPortfolio) generate.! !

!PortfolioTreePrinterTest methodsFor: 'test' stamp: 'SRS 12/6/2021 17:03:01'!
test03PortfolioTreePrinterOfPortfolioWithReceptiveAccountAndAPortfolio
	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos'.

	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	self assert: expectedResult03 equals: (TreePrinter of: familyPortfolio) generate.! !

!PortfolioTreePrinterTest methodsFor: 'test' stamp: 'SRS 12/6/2021 17:03:01'!
test04PortfolioTreePrinterOfPortfolioWithReceptiveAccountAndAPortfolioWithReceptiveAccounts
	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount. 
	
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	self assert: expectedResult04 equals: (TreePrinter of: familyPortfolio) generate.! !


!classDefinition: #TransferNetTest category: 'ServiciosFinancieros-2'!
TestSF2 subclass: #TransferNetTest
	instanceVariableNames: 'firstAccount secondAccount portfolio emptyExpectedNetValue transferDepositExpectedNetValue transferWithdrawExpectedNetValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!TransferNetTest methodsFor: 'test' stamp: 'LG 12/3/2021 17:25:51'!
setUp

	firstAccount := ReceptiveAccount new.	
	
	secondAccount := ReceptiveAccount new.
	
	portfolio := Portfolio with: firstAccount.
	
	emptyExpectedNetValue := 'Neto de transferencia = 0 * pesos'.
	
	transferDepositExpectedNetValue := 'Neto de transferencia = 30 * pesos'.
	
	transferWithdrawExpectedNetValue := 'Neto de transferencia = -20 * pesos'.! !

!TransferNetTest methodsFor: 'test' stamp: 'SRS 12/6/2021 17:03:01'!
test01AnAccountWithoutMovementsHasZeroAccountNetTransferValue

	self assert: emptyExpectedNetValue equals: (AccountTransferNet of: firstAccount) generate.! !

!TransferNetTest methodsFor: 'test' stamp: 'SRS 12/6/2021 17:03:01'!
test02AnAccountWithDepositHasZeroAccountNetTransferValue
	
	Deposit register: 100 * peso on: firstAccount. 

	self assert: emptyExpectedNetValue equals: (AccountTransferNet of: firstAccount) generate.! !

!TransferNetTest methodsFor: 'test' stamp: 'SRS 12/6/2021 17:03:01'!
test03AnAccountWithWithdrawHasZeroAccountNetTransferValue
	
	Withdraw register: 50 * peso on: firstAccount.

	self assert: emptyExpectedNetValue equals: (AccountTransferNet of: firstAccount) generate.! !

!TransferNetTest methodsFor: 'test' stamp: 'SRS 12/6/2021 17:03:01'!
test04AnAccountWithTransferDepositHasTheCorrectAccountNetTransferValue
	
	Transfer amount: 30 * peso from:  secondAccount to: firstAccount. 

	self assert: transferDepositExpectedNetValue equals: (AccountTransferNet of: firstAccount) generate.
! !

!TransferNetTest methodsFor: 'test' stamp: 'SRS 12/6/2021 17:03:01'!
test05AnAccountWithTransferWithdrawHasTheCorrectAccountNetTransferValue
	
	Transfer amount: 20 * peso from:  firstAccount to: secondAccount. 

	self assert: transferWithdrawExpectedNetValue equals: (AccountTransferNet of: firstAccount) generate.! !


!classDefinition: #Account category: 'ServiciosFinancieros-2'!
Object subclass: #Account
	instanceVariableNames: 'accountName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'initialization - extra' stamp: 'SRS 12/5/2021 18:08:20'!
initializeNamed: anAccountName

	self subclassResponsibility. ! !


!Account methodsFor: 'tree printer - extra' stamp: 'SRS 12/6/2021 16:49:22'!
addToAnAccountReport: anAccountReport

	self subclassResponsibility. ! !

!Account methodsFor: 'tree printer - extra' stamp: 'SRS 12/5/2021 18:09:09'!
name

	^ accountName copy. ! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'ServiciosFinancieros-2'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'initialization' stamp: 'LG 12/4/2021 00:39:56'!
named: anAccountName

	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-2'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!Portfolio methodsFor: 'initialization - extra' stamp: 'LG 12/4/2021 00:48:22'!
initializeNamed: anAccountName

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	accountName := anAccountName.! !

!Portfolio methodsFor: 'initialization - extra' stamp: 'LG 12/4/2021 00:48:29'!
initializeNamed: anAccountName with: anAccount 
	
	accounts := OrderedCollection with: anAccount.
	parents := OrderedCollection new.
	accountName := anAccountName.
	
	! !

!Portfolio methodsFor: 'initialization - extra' stamp: 'LG 12/4/2021 00:48:33'!
initializeNamed: anAccountName with: anAccount with: anotherAccount 

	accounts := OrderedCollection with: anAccount with: anotherAccount.
	parents := OrderedCollection new.
	accountName := anAccountName.

! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'tree printer - extra' stamp: 'SRS 12/6/2021 16:50:27'!
addToAccountReport: aReportToPrint

	aReportToPrint addAPortfolio: self.
	! !


!Portfolio methodsFor: 'main protocol' stamp: 'lg 11/30/2021 16:57:51'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 * peso]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'SRS 12/5/2021 17:42:38'!
withAccountsDo: aClosure

	accounts do: aClosure. ! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-2'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'as yet unclassified' stamp: 'LG 12/4/2021 00:40:32'!
named: anAccountName

	^self new initializeNamed: anAccountName.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'LG 12/4/2021 00:27:44'!
named: aString with: aReceptiveAccount 
	
	^self new initializeNamed: aString with: aReceptiveAccount ! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'LG 12/4/2021 00:42:23'!
named: aString with: aReceptiveAccount with: aPortfolio 

	^self new initializeNamed: aString with: aReceptiveAccount with: aPortfolio ! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-2'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'lg 11/30/2021 16:57:40'!
balance

	^transactions 
		inject: 0 * peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'LG 12/3/2021 17:33:21'!
withTransactionsDo: aClosure 

	transactions do: aClosure.! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'initialization - extra' stamp: 'LG 12/4/2021 00:39:17'!
initializeNamed: anAccountName

	accountName := anAccountName. 
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'tree printer - extra' stamp: 'SRS 12/6/2021 16:56:23'!
addToAccountReport: aReportToPrint

	aReportToPrint addAReceptiveAccount: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-2'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'LG 12/4/2021 00:39:17'!
named: anAccountName

	^self new initializeNamed: anAccountName. ! !


!classDefinition: #AccountReports category: 'ServiciosFinancieros-2'!
Object subclass: #AccountReports
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!AccountReports methodsFor: 'initialization' stamp: 'SRS 12/6/2021 17:03:01'!
generate

	self subclassResponsibility. ! !

!AccountReports methodsFor: 'initialization' stamp: 'SRS 12/2/2021 20:25:13'!
initializeWith: AnAccount

	self subclassResponsibility. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReports class' category: 'ServiciosFinancieros-2'!
AccountReports class
	instanceVariableNames: ''!

!AccountReports class methodsFor: 'initialization' stamp: 'SRS 12/6/2021 16:33:23'!
of: anAccount

	^ self new initializeWith: anAccount.! !


!classDefinition: #AccountSpecialReports category: 'ServiciosFinancieros-2'!
AccountReports subclass: #AccountSpecialReports
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!


!classDefinition: #DetailedTreePrinter category: 'ServiciosFinancieros-2'!
AccountSpecialReports subclass: #DetailedTreePrinter
	instanceVariableNames: 'portfolio portfolioTree'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!DetailedTreePrinter methodsFor: 'initialization' stamp: 'SRS 12/5/2021 17:44:02'!
initializeWith: aPortfolio
	
	portfolio := aPortfolio. 
	portfolioTree := OrderedCollection new.! !


!DetailedTreePrinter methodsFor: 'main protocol' stamp: 'SRS 12/6/2021 17:03:01'!
generate

	portfolioTree add: portfolio name.
	
	portfolio withAccountsDo: [ :anAccount | anAccount addToAccountReport: self 	]. 
	
	portfolioTree add: '   Balance = ', portfolio balance asString.
	
	^portfolioTree! !


!DetailedTreePrinter methodsFor: 'private' stamp: 'SRS 12/6/2021 17:03:01'!
addAPortfolio: aPortfolio

	(DetailedTreePrinter of: aPortfolio) generate do: [:accountDetailedPrinter | portfolioTree add: '   ', accountDetailedPrinter].! !

!DetailedTreePrinter methodsFor: 'private' stamp: 'SRS 12/6/2021 17:03:01'!
addAReceptiveAccount: aReceptiveAccount

	portfolioTree add: '   ', aReceptiveAccount name. 
	(AccountSummary of: aReceptiveAccount ) generate do: [:accountSummary | portfolioTree add: '      ', accountSummary].
! !


!classDefinition: #TreePrinter category: 'ServiciosFinancieros-2'!
AccountSpecialReports subclass: #TreePrinter
	instanceVariableNames: 'portfolio portfolioTree'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!TreePrinter methodsFor: 'initialization' stamp: 'SRS 12/5/2021 17:43:26'!
initializeWith: aPortfolio

	portfolio := aPortfolio. 
	portfolioTree := OrderedCollection new.! !


!TreePrinter methodsFor: 'private' stamp: 'SRS 12/6/2021 17:03:01'!
addAPortfolio: aPortfolio

	(TreePrinter of: aPortfolio) generate do: [ :anAccount | portfolioTree add: '   ', anAccount ].! !

!TreePrinter methodsFor: 'private' stamp: 'SRS 12/5/2021 17:54:01'!
addAReceptiveAccount: aReceptiveAccount

	portfolioTree add: '   ', aReceptiveAccount name asString.! !


!TreePrinter methodsFor: 'main protocol' stamp: 'SRS 12/6/2021 17:03:01'!
generate
	
	portfolioTree add: portfolio name.
	
	portfolio withAccountsDo: [ :anAccount | 		anAccount  addToAccountReport: self	 	].
	
	^portfolioTree.
	! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-2'!
AccountReports subclass: #AccountSummary
	instanceVariableNames: 'account accountSummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!AccountSummary methodsFor: 'initialization' stamp: 'LG 12/3/2021 17:34:11'!
initializeWith: anAccount

	accountSummary := OrderedCollection new.
	account := anAccount.! !


!AccountSummary methodsFor: 'private' stamp: 'SRS 12/2/2021 20:35:35'!
addDescriptionOfDeposit: aDeposit
	
	accountSummary add: ('Deposito por ', aDeposit value asString).! !

!AccountSummary methodsFor: 'private' stamp: 'SRS 12/2/2021 20:36:03'!
addDescriptionOfTransferDeposit: aTransferDeposit
	
	accountSummary add: ('Entrada por transferencia de ', aTransferDeposit value asString).! !

!AccountSummary methodsFor: 'private' stamp: 'SRS 12/2/2021 20:36:20'!
addDescriptionOfTransferWithdraw: aTransferWithdraw
	
	accountSummary add: ('Salida por transferencia de ', aTransferWithdraw value asString).! !

!AccountSummary methodsFor: 'private' stamp: 'SRS 12/2/2021 20:36:32'!
addDescriptionOfWithdraw: aWithdraw
	
	accountSummary add: ('Extraccion por ', aWithdraw value asString).! !


!AccountSummary methodsFor: 'main protocol' stamp: 'SRS 12/6/2021 17:03:01'!
generate
	
	account withTransactionsDo: [ :anAccountTransaction | anAccountTransaction addDescriptionToAccountReport: self ].
	
	accountSummary add: 'Balance = ', account balance asString.
	
	^accountSummary
	! !


!classDefinition: #AccountTransferNet category: 'ServiciosFinancieros-2'!
AccountReports subclass: #AccountTransferNet
	instanceVariableNames: 'account accountNetValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!AccountTransferNet methodsFor: 'main protocol' stamp: 'SRS 12/2/2021 20:59:45'!
viewAffectedItsTransferNetValueByADeposit! !

!AccountTransferNet methodsFor: 'main protocol' stamp: 'SRS 12/2/2021 21:27:56'!
viewAffectedItsTransferNetValueByATransferDeposit: aTransferDeposit

	accountNetValue := accountNetValue + aTransferDeposit value.! !

!AccountTransferNet methodsFor: 'main protocol' stamp: 'SRS 12/2/2021 21:28:01'!
viewAffectedItsTransferNetValueByATransferWithdraw: aTransferWithdraw

	accountNetValue := accountNetValue - aTransferWithdraw value.! !

!AccountTransferNet methodsFor: 'main protocol' stamp: 'SRS 12/2/2021 20:59:52'!
viewAffectedItsTransferNetValueByAWithdraw! !


!AccountTransferNet methodsFor: 'initialization' stamp: 'SRS 12/6/2021 17:03:01'!
generate
	
	account withTransactionsDo: [ :aTransaction | aTransaction affectNetValueOnAccountReport: self].

	^'Neto de transferencia = ', accountNetValue asString.! !

!AccountTransferNet methodsFor: 'initialization' stamp: 'LG 12/3/2021 17:34:22'!
initializeWith: anAccount

	accountNetValue := 0 * peso.
	account := anAccount.

	 ! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-2'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'private' stamp: 'SRS 12/6/2021 17:01:47'!
addDescriptionToAccountReport: anAccountReport

	self subclassResponsibility.! !

!AccountTransaction methodsFor: 'private' stamp: 'SRS 12/6/2021 17:02:22'!
affectNetValueOnAccountReport: anAccountReport

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-2'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'reports' stamp: 'SRS 12/6/2021 17:01:47'!
addDescriptionToAccountReport: anAccountReport

	anAccountReport addDescriptionOfDeposit: self.! !

!Deposit methodsFor: 'reports' stamp: 'SRS 12/6/2021 17:02:22'!
affectNetValueOnAccountReport: anAccountReport

	anAccountReport viewAffectedItsTransferNetValueByADeposit. ! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-2'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-2'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-2'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-2'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'netTransferBalance' stamp: 'SRS 12/6/2021 17:01:47'!
addDescriptionToAccountReport: accountSummary

	accountSummary addDescriptionOfTransferDeposit: self.! !

!TransferDepositLeg methodsFor: 'netTransferBalance' stamp: 'SRS 12/6/2021 17:02:22'!
affectNetValueOnAccountReport: anAccountReport

	anAccountReport viewAffectedItsTransferNetValueByATransferDeposit: self. ! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-2'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'netTransferBalance' stamp: 'SRS 12/6/2021 17:01:47'!
addDescriptionToAccountReport: accountSummary

	accountSummary addDescriptionOfTransferWithdraw: self.! !

!TransferWithdrawLeg methodsFor: 'netTransferBalance' stamp: 'SRS 12/6/2021 17:02:22'!
affectNetValueOnAccountReport: anAccountReport	
	
	anAccountReport viewAffectedItsTransferNetValueByATransferWithdraw: self. ! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'SRS 12/6/2021 17:02:22'!
affectNetValueOnAccountReport: anAccountReport

	anAccountReport viewAffectedItsTransferNetValueByAWithdraw. ! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'netTransferBalance' stamp: 'SRS 12/6/2021 17:01:47'!
addDescriptionToAccountReport: accountSummary

	accountSummary addDescriptionOfWithdraw: self.! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-2'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-2'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-2'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
