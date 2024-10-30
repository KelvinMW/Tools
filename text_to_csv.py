import csv

def txt_to_csv(txt_file, csv_file):
  """Converts a space-delimited TXT file to a CSV file.

  Args:
    txt_file: Path to the input TXT file.
    csv_file: Path to the output CSV file.
  """

  with open(txt_file, 'r') as infile, open(csv_file, 'w', newline='') as outfile:
    writer = csv.writer(outfile)
    for row in infile:
      writer.writerow(row.strip().split())

# Example usage:
txt_file = 'input.txt'
csv_file = 'output.csv'
txt_to_csv(txt_file, csv_file)
