DELIMITER //
CREATE PROCEDURE checkOut(IN patronID INT, IN bookID INT)
BEGIN
	INSERT INTO loan(patron_id,date_out,book_id)
    VALUES (patronID,CURDATE(),bookID);
    UPDATE book SET available=false WHERE book_id=bookID;
    UPDATE patron INNER JOIN loan SET patron.loan_id = (SELECT MAX(loan_id) FROM loan WHERE patron_id=patronID AND date_in IS NULL) WHERE patron.patron_id=patronID;
END//
CREATE PROCEDURE checkIn(IN patronID INT, IN bookID INT)
BEGIN
	UPDATE loan SET date_in = CURDATE();
    UPDATE book SET available=true WHERE book_id=bookID;
    UPDATE patron SET patron.loan_id = NULL WHERE patron.patron_id=patronID;
END//
DELIMITER ;
