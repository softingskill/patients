package com.filemanager.backend.dao.interfaces;

import java.util.List;

import com.filemanager.utils.transporters.entities.Calendar;
import com.filemanager.utils.transporters.entities.Event;

public interface CalendarDao {

	Calendar addCalendarForDoctor(int doctorId);

	Event addEvent(Event event);

	boolean updateEvent(Event event);

	List<Event> getEvents(int calendarId);

	Event getEventById(int eventId);

	boolean removeEvent(Event event);

	boolean deleteCalendar(Calendar calendar);

}
