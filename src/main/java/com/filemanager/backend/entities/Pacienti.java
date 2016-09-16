package com.filemanager.backend.entities;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Pacienti implements Serializable{

	private static final long serialVersionUID = 6635717949381968011L;
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	private String nume;
	private String prenume;

	@OneToOne(mappedBy="pacient",fetch=FetchType.LAZY)
	private DetaliiPacient detaliiPacient = new DetaliiPacient();

	@ManyToOne(fetch = FetchType.LAZY)
	private Doctori doctor;

	@OneToMany(fetch = FetchType.LAZY)
	@JoinColumn(name="id")
	private List<Consultatii> consultatii;

	public List<Consultatii> getConsultatii() {
		return consultatii;
	}

	public void setConsultatii(List<Consultatii> consultatii) {
		this.consultatii = consultatii;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNume() {
		return nume;
	}

	public void setNume(String nume) {
		this.nume = nume;
	}

	public String getPrenume() {
		return prenume;
	}

	public void setPrenume(String prenume) {
		this.prenume = prenume;
	}

	public DetaliiPacient getDetaliiPacient() {
		return detaliiPacient;
	}

	public void setDetaliiPacient(DetaliiPacient detaliiPacient) {
		this.detaliiPacient = detaliiPacient;
	}

	public Doctori getDoctor() {
		return doctor;
	}

	public void setDoctor(Doctori doctor) {
		this.doctor = doctor;
	}

}
